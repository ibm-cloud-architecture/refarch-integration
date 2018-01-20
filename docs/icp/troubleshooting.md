# Troubleshooting in ICP

## hostname not resolved
  ```
   fatal: [...] => Failed to connect to the host via ssh: ssh: Could not resolve hostname ...:
   Name or service not known
  ```
  * verify the hostname match the ip address in /etc/hosts
  * be sure to start the installation from the folder with the hosts file. It should be cluster or modify $(pwd) to $(pwd)/cluster

## ssh connect failure
  ```
  fatal: [192.168.1.147] => Failed to connect to the host via ssh:
  Permission denied (publickey,password).
  ```
This is a problem of accessing root user during the installation. Be sure to authorize root login, (ssh_config file), that the ssh_key is in the root user home/.ssh. See [above](#ubuntu-specifics)


While login from a developer's laptop.
```
$ docker login cluster.icp:8500
>
Error response from daemon: Get https://cluster.icp:8500/v2/: net/http:
request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)
```
Be sure the cluster.icp hostname is mapped to the host's IP address in the local /etc/hosts

## Unknown certificate authority
```
$ docker login mycluster.icp:8500
Error response from daemon: Get https://mycluster.icp:8500/v2/: x509: certificate signed by unknown authority
```

Go to your docker engine configuration and add the remote registry as an insecure one. On MAC you select the docker > preferences > Advanced meny and then add the remote master name
```json
{
  "debug" : true,
  "experimental" : true,
  "insecure-registries" : [
    "jbcluster.icp:8500",
    "mycluster.icp:8500"
  ]
}
```

You can also verify the certificates are in the logged user **~/.docker** folder. This folder should have a **certs.d** folder and one folder per remote server, you need to access. So the mycluster.icp:8500/ca.crt file needs to be copied there too.

## Not able to login to docker running on master node
Different type of messages:
### Unknown authority
`Error response from daemon: Get https://greencluster.icp:8500/v2/: x509: certificate signed by unknown authority.
You need to configure your local docker to accept to connect to insecure registries by adding an entry about the target host.
On MACOS the Preferences> Daemon > Advanced   

![](docker-pref-insecure-reg.png)


See also the note about accessing ICP private repository [here](https://github.com/ibm-cloud-architecture/refarch-cognitive/tree/master/docs/ICP#access-to-icp-private-docker-repository) and how to copy SSL certificate to your local host.

### x509 certificate not valid for a specific hostname
Be sure the hostname you are using is in your /etc/hosts and you `docker login` to the good host.

## Pod not getting the image from docker private repository
Looking at the Events report from the pod view you got a message like:
```
Failed to pull image “greencluster.icp:8500/greencompute/customerms:v0.0.7”: rpc error: code = Unknown desc = Error response from daemon: Get https://greencluster.icp:8500/v2/greencompute/customerms/manifests/v0.0.7: unauthorized: authentication required
```

The new version of k8s enforces the use of secret to access the docker private repository. So you need to add a secret, named for example regsecret, for the docker registry object.
```
$ kubectl create secret docker-registry regsecret --docker-server=172.16.40.130 --docker-username=admin --docker-password=<> --docker-email=<email> --namespace=greencompute
$ kubectl get secret regsecret --output=yaml --namespace=greencompute
```
Then modify the deployment.yaml to reference this secret so the pod can access the repo during deployment:
```  spec:
    containers:
      - name: {{ .Chart.Name }}
        image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
        ....
    imagePullSecrets:
      - name: regsecret
```

## Verify deployment
When you deploy a helm chart you can assess how the deployment went using the ICP admin console or the kubectl CLI.

For the user interface, go to the ** Workloads > Deployments ** menu to access the list of current deployments. Select the deployment and then the pod list.
In the pod view select the events to assess how the pod deployment performed

![](icp-pod-events.png)

and the log file in *Logs* menu

![](icp-pod-logs.png)

Using kublectl to get the status of a deployment
```
$ kubectl get deployments --namespace browncompute
> NAME                          DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
casewebportal-casewebportal   1         1         1            1           2d

```
or a specific detail view:
```
kubectl describe deployment browncompute-dal-browncompute-dal
```

Get the logs and events
```
$  export POD_NAME=$(kubectl get pods --namespace browncompute -l "app=casewebportal-casewebportal" -o jsonpath="{.items[0].metadata.name}")

$ kubectl logs $POD_NAME --namespace browncompute

$  kubectl get events --namespace browncompute  --sort-by='.metadata.creationTimestamp'
```

## Kubectl helpful commands
```
$ kubectl get pods

$ kubectl describe pods

$ export POD_NAME=$(kubectl get pods -o go-template='{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}’)

$ kubectl exec $POD_NAME env  --namespace browncompute

$ kubectl logs $POD_NAME

# run an alpine shell connected to the container
$ kubectl exec -ti $POD_NAME /bin/ash
> ls

$ kubectl get services

$ export NODE_PORT=$(kubectl get services/casewdsbroker -o go-template='{{(index .spec.ports 0).nodePort}}')

$ kubectl describe deployment
```

## Error while getting cluster info
Try to do 'kubectl cluster-info': failed: error: You must be logged in to the server (the server has asked for the client to provide credentials)
Be sure to have use the settings from the 'configure client'.
Be sure the cluster name / IP address are mapped in /etc/hosts
Be sure to have a ca.crt into
Use the `bx pr login -a <clustername>/api -u admin` command


#### default backend - 404
This error can occur if the ingress rules are not working well.

1. Assess if ingress is well defined: virtual hostname, proxy adddress and status/age of running
  ```
  kubectl get ing --namespace browncompute

  > NAME                                HOSTS               ADDRESS        PORTS     AGE
browncompute-dal-browncompute-dal   dal.brown.case      172.16.40.31   80        59m
casewebportal-casewebportal         portal.brown.case   172.16.40.31   80        10d
  ```

  1. Get the detail of ingress rules, and its mapping to the expected service, the path and host mapping.
  ```
  kubectl describe ingress browncompute-dal-browncompute-dal  --namespace browncompute


  Name:			browncompute-dal-browncompute-dal
Namespace:		browncompute
Address:		172.16.40.31
Default backend:	default-http-backend:80 (10.100.221.196:8080)
Rules:
  Host			Path	Backends
  ----			----	--------
  dal.brown.case
    			/ 	inventorydalsvc:9080 (<none>)
Annotations:
No events.
  ```
