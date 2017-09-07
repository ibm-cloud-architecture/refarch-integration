# IBM Cloud Private Deployment
In this section we are presenting how *Hybrid integration compute* is deployed to ICp.

The following diagram presents the target deployment approach.

![Brown on ICP](./bc-icp-bt-view.png)

The Web app is packaged as docker container and deploy to ICp kubernetes cluster, as well as the JAXWS app running on Liberty, and the Gateway flow running on IBM Integration Bus. The LDAP, DB2 server and the API Connect servers are still running on Traditional IT servers. The build server will also stay on-premise as it is used by multiple teams. The approach is to illustrate a realist configuration often seen in current IT data center.

# Use a ICp instance for development
We have created a single VM to host ICp for development purpose. The detailed steps are documented [here](install-dev-icp21.md)

# Deployment for each components
* For IIB study this article: [Deploying IIB Application to IBM Cloud private](https://github.com/ibm-cloud-architecture/refarch-integration-esb/blob/master/deploy/README.md)
* For the web application: [Deploy to ICp](https://github.com/ibm-cloud-architecture/refarch-caseinc-app/blob/master/docs/run-icp.md)

# Installing a ICp for development
It may be interesting to setup ICp community edition on a unique VM with all one master, one worker node, one proxy.
TBD.

# Setup Private Docker Registry
In this section you will set up the private Docker registry in ICp to host the Docker images securely. For this you will create an ICp user to access the registry, and kubernetes configmap and secret resources for the registry configuration and credentials.
