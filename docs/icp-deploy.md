# IBM Cloud Private Deployment
In this section we are presenting how *Hybrid integration compute* is deployed to ICp.

The following diagram presents the target deployment approach.

![Brown on ICP](./bc-icp-bt-view.png)

The Web app is packaged as docker container and deploy to ICp kubernetes cluster, as well as the JAXWS app running on Liberty, and the Gateway flow running on IBM Integration Bus. The LDAP, DB2 server and the API Connect servers are still running on Traditional IT servers. The build server will also stay on-premise as it is used by multiple teams. This approach is to illustrate a real hybrid IT environment or not all the pieces run on cloud based solutions.

# Use a ICp instance for development
We have created a single VM to host ICp for development purpose. The detailed steps are documented [here](install-dev-icp21.md)

# Install Kubectl
You need to have kubectl on your development computer and on the ICp development server. The steps are the same:
* Install kubectl from ibm image.
```
```

# Deployment for each component
* For IIB study this article: [Deploying IIB Application to IBM Cloud private](https://github.com/ibm-cloud-architecture/refarch-integration-esb/blob/master/deploy/README.md)
* For the web application see [Deploy to ICp](https://github.com/ibm-cloud-architecture/refarch-caseinc-app/blob/master/docs/run-icp.md):
* For the data access layer SOA service running on WebSphere Liberty [Deploy DAL to ICp]()


# Setup Private Docker Registry
In this section you will set up the private Docker registry in ICp to host the Docker images securely. For this you will create an ICp user to access the registry, and kubernetes configmap and secret resources for the registry configuration and credentials.
