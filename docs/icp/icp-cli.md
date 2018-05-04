
## Install CLI on your computer
https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0/manage_cluster/scripts/install_cli.html

* Login to your cluster
```
bx pr login -a https://<master_ip_address>:8443 --skip-ssl-validation
```
* Work on deployments
```
# get all deployments
kubectl get deployments --all-namespaces
# get specifics deployments
k get deployment jenkins -n browncompute
# get pod details
kubectl get pods -l component=jenkins-jenkins-master  -n browncompute
```
* See a specific config map
` kubectl get configMap <name-of-the-map> --namespace browncompute`

## Summary of CLI commands
* [ICP CLI](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0.2/manage_cluster/cli_commands.html)
* [kubectl playground](https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands)


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
