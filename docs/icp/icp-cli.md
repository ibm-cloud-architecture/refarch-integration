
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
bx pr login -a https://<master_ip_address>:8443 --skip-ssl-validation
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
# get all deployments
kubectl get deployments --all-namespaces
# get specifics deployments
k get deployment jenkins -n browncompute
# get pod details
kubectl get pods -l component=jenkins-jenkins-master  -n browncompute
```
* See a specific config map
` kubectl get configMap <name-of-the-map> --namespace browncompute`

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
