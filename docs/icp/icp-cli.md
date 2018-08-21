
# ICP or Bluemix Container Service CLI Summary

## IBM Cloud (Bluemix CLI)
```
$ bx login -a api.ng.bluemix.net
# Review the locations that are available.
$ bx cs locations
# Choose a location and review the machine type
$ bx cs machine-types dal10
# Assess if a public and private VLAN already exists in the Bluemix Infrastructure  NEED a paid account
$ bx cs vlans dal10
# When the provisioning of your cluster is completed, the status of your cluster changes to deployed
$ bx cs clusters
# Check the status of the worker nodes
$ bx cs workers cyancomputecluster
```

## Install CLIs
https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0.2/manage_cluster/scripts/install_cli.html

## Summary of CLI commands
* Login to your cluster
```
bx pr login -a https://<master_ip_address>:8443 --skip-ssl-validation -a <accountname>
```
* Assess cluster name and status
```
 bx pr clusters
```
* Configure the cluster to get cert.pem and key.pem certificates added to ~/.helm folder:
```
 bx pr cluster-config ext-demo
```

# Work on deployments
* [Kubectl official cheatsheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
* [ICP CLI formal doc](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0.2/manage_cluster/cli_commands.html)
* [kubectl playground](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands)
```
# Get cluster context
kubectl config set-cluster gr33n-cluster --server=https://gr33n-cluster:8001  --insecure-skip-tls-verify=true
kubectl config set-cluster gr33n-cluster --server=https://gr33n-cluster:8001 --insecure-skip-tls-verify=true
kubectl config set-context gr33n-cluster --cluster=gr33n-cluster --user=admin --insecure-skip-tls-verify=true
kubectl config set-credentials admin --client-certificate=gr33n-cluster/cert.pem  --client-key=gr33n-cluster/key.pem
kubectl config use-context gr33n-cluster

# get all deployments
kubectl get deployments --all-namespaces
# get specifics deployments
kubectl get deployment jenkins -n browncompute
# Add a deployment from a yaml file
kubectl create -f deployment.yaml

# get pod details
kubectl get pods -l component=jenkins-jenkins-master  -n browncompute
```
* See a specific config map
` kubectl get configMap <name-of-the-map> --namespace browncompute`

```
$ kubectl get pods

$ kubectl describe pod podid

$ export POD_NAME=$(kubectl get pods -o go-template='{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}’)

$ kubectl exec $POD_NAME env  --namespace browncompute

$ kubectl logs $POD_NAME

# run an alpine shell connected to the container
$ kubectl exec -ti $POD_NAME /bin/ash
> ls

$ kubectl get services

$ export NODE_PORT=$(kubectl get services/casewdsbroker -o go-template='{{(index .spec.ports 0).nodePort}}')

$ kubectl describe deployment

# Apply change to existing pod
$ kubectl apply -f filename.yml

# Access to a pod using node port: example for cassandra pod.
$ k port-forward cassandra-0 9042:9042
```

## helm CLI
```
# create a new helm chart:
 helm create <chartname>

# Install a charts on a connected ICP
helm install  browncompute-dal/ --name  browncompute-dal --namespace browncompute --tls

# delete an existing release
helm del --purge browncompute-dal --tls
```
The `--purge` flag makes sure that the `browncompute-dal` release name is reusable for a fresh install if you decide to use the same release name again.
