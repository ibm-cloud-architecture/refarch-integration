# Troubleshooting in ICP

## Not able to login to docker running on master node
The type of messages
### Unknown authority
`Error response from daemon: Get https://greencluster.icp:8500/v2/: x509: certificate signed by unknown authority.
You need to configure your local docker to accept to connect to insecure registries by adding an entry about the target host.
On MACOS the Preferences> Daemon > Advanced   

![](docker-pref-insecure-reg.png)


See also the note about accessing ICP private repository [here](https://github.com/ibm-cloud-architecture/refarch-cognitive/tree/master/docs/ICP#access-to-icp-private-docker-repository) and how to copy SSL certificate to your local host.

### x509 certificate not valid for a specific hostname
Be sure the hostname you are using is in your /etc/hosts and you `docker login` to the good host.

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

$ kubectl exec $POD_NAME env

$ kubectl logs $POD_NAME

# run an alpine shell connected to the container
$ kubectl exec -ti $POD_NAME /bin/ash
> ls

$ kubectl get services

$ export NODE_PORT=$(kubectl get services/casewdsbroker -o go-template='{{(index .spec.ports 0).nodePort}}')

$ kubectl describe deployment
```

## Understanding networking
TBD
