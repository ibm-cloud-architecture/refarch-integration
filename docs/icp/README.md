# IBM Cloud Private Deployment
In this section we are presenting how *Hybrid integration compute implementation* is deployed to IBM Cloud Private. For that we will address different configurations as business and operation requirements may differ per data center and even per business application.

Updated 01/04/2017

## Table of Contents
* [Prerequisites](#prerequisites)
* [Community Edition installation (for development environment)](./dev-env-install.md)
* [Enterprise Edition Installation](https://github.com/ibm-cloud-architecture/refarch-privatecloud/blob/master/Installing_ICp_on_prem.md)
* [Hybrid integration deployment configurations](#configurations) We are proposing different configurations for the deployment of each components of the solution: Webapp, API gateway, message flow, SOAP service, data base.
* [Troubleshooting](troubleshooting.md)

## Prerequisites
The following points should be considered before going in more detail of the ICP deployment:
* A conceptual understanding of how [Kubernetes](https://kubernetes.io/docs/concepts/) works.
* A high-level understanding of [Helm and Kubernetes package management](https://docs.helm.sh/architecture/).
* A basic understanding of [IBM Cloud Private cluster architecture](https://www.ibm.com/support/knowledgecenter/SSBS6K_2.1.0/getting_started/architecture.html).
* Understand the different [ICP environment and sizing](https://github.com/ibm-cloud-architecture/refarch-privatecloud/blob/master/Sizing.md)
* Access to an operational IBM Cloud Private cluster [see installation note](./dev-env-install.md) for the different approaches.

A developer needs to have on his development environment the following components:
* [Docker](dev-env-install.md#install-docker)
* [Kubectl](dev-env-install.md#install-kubectl)
* [Helm](dev-env-install.md#install-helm)
we have provided a shell script to do those installation. Execute `./install_cli.sh` ( or `./install_cli.bat` for Windows)

* Add a **browncompute** namespace using ICP admin console, under **Admin > Namespaces** menu

![](icp-brown-ns.png)

We will use this namespace to push the *hybrid integration* components into ICP cluster.

# Configurations
As an hybrid solution each component of the solution may run on existing on-premise server or on IBM Cloud Private. The deployment decision will be driven by the business requirements and the availability of underlying IBM middleware product as docker image.

For each component of the 'hybrid integration' solution the following needs may be done:
   * build the docker image
   * tag the image with information about the target repository server, namespace, tag and version
   * push the image to the remote docker repository (most likely the one inside ICP)
   * build the helm package from the chart definition
   * install the chart to ICP cluster using *helm* command line interface
   * access the URL end point

## Cfg 1: Cloud native application on ICP
This is the simplest deployment where the cloud native web application ([the 'case' portal](https://github.com/ibm-cloud-architecture/refarch-caseinc-app)) is deployed as container running in ICP, and accesses the back end service via API Connect running on-premise. All other components run on-premise.

![WebApp](./bc-icp-cfg1.png)

This approach will be the less disruptive, let the development team innovating with new polyglot runtime environments supported by cloud native based application and micro services.

To support this configuration you need to:  
1. compile and package the web application as docker container
1. define a helm chart for ICP using yaml files
1. use `helm` and `kubectl` command line interfaces to install and control the chart deployment
1. test with integration tests as defined in [this project](https://github.com/ibm-cloud-architecture/refarch-integration-tests)

For the web app deployment follow the step by step [tutorial here](https://github.com/ibm-cloud-architecture/refarch-caseinc-app/blob/master/docs/icp/README.md).

If you want to review each component, their descriptions are below:
* [API Connect - Inventory product](https://github.com/ibm-cloud-architecture/refarch-integration#inventory-management)
* [Gateway flow in integration broker](https://github.com/ibm-cloud-architecture/refarch-integration-esb#inventory-flow)
* [SOAP service for data access Layer](https://github.com/ibm-cloud-architecture/refarch-integration-inventory-dal#code-explanation)
* [Inventory database](https://github.com/ibm-cloud-architecture/refarch-integration-inventory-db2#inventory-database)

## Cfg 2: Web App, Datapower Gateway on ICP
The goal for this configuration is to deploy Data power gateway to IBM cloud private and deploy the interaction APIs on it. The API product definition is split into interaction APIs and system APIs.

![](./bc-icp-cfg2.png)

The second Datapower gateway is used to present 'System' APIs. (see this redbook ["A practical Guide for IBM Hybrid Integration Platform"](http://www.redbooks.ibm.com/redbooks/pdfs/sg248351.pdf) for detail about this clear APIs separation)

The `gateway flow`, deployed on IIB, is doing the REST to SOAP interface mapping: this configuration illustrates deep adoption of the ESB pattern leveraging existing high end deployments, scaling both horizontally and vertically. In this model the concept of operation for mediation and integration logic development is kept.

The steps are:
1. Modify the webapp configuration to use a different URL for the gateway flow: The settings is done in the `values.yaml` in the chart folder of the [case portal app](https://github.com/ibm-cloud-architecture/refarch-caseinc-app)
1. Deploy webapp to ICP [following the tutorial as seen in configuration 1](https://github.com/ibm-cloud-architecture/refarch-caseinc-app/blob/master/docs/icp/README.md)
1. Deploy API Connect gateway from ICP Catalog using [this tutorial](https://github.com/ibm-cloud-architecture/refarch-integration-api/blob/master/docs/icp/README.md)
1. Deploy the api product to the new gateway.

## Cfg 3: Web App, Datapower Gateway and Liberty App on ICP

For this configuration the web service application running on WebSphere Liberty profile is moved to ICP, while IIB stays on premise, as well as the data base servers. Basically the approach is to keep heavy investment as-is as they are most likely supporting other data base instances and message flows used by other applications. Still the light weight applications can move easily to ICP. The interaction APIs is on ICP while the System APIs are running closer to the integration bus. This is more an API ownership control than a technology constraint.

![Brown on ICP](./bc-icp-cfg3.png)

To support this configuration on top of config 2, the  *Inventory Data Access Layer* app running on Liberty is packaged as docker container and deployed using helm chart deployment configuration.

The step by step instructions are in [the deploy DAL to ICP  tutorial](https://github.com/ibm-cloud-architecture/refarch-integration-inventory-dal/blob/master/docs/icp/README.md).

The LDAP, DB2 server servers are still running on Traditional IT servers.

## Cfg 4: Integration Bus as micro flow running in ICP
This configuration is using integration components on premise and the other more lightweight components on ICP, and add a micro-service for integration as introduced in [this article](https://developer.ibm.com/integration/blog/2017/04/16/12-factor-integration/) using a message flow deployed on IIB runninig in ICP.

![](./bc-icp-cfg4.png)

We also have added Operation Decision Management product packaged as container and deployed on ICP following instructions: [ODM on Docker, Kubernetes, and IBM Cloud Private](https://developer.ibm.com/odm/2017/10/02/odm-docker-kubernetes-ibm-cloud-private/)

This approach leverages existing investment and IIB concept of operation, and IBM Datapower for security and API gateway. This approach has an impact on the way to manage application inside IIB. Instead of deploying multiple applications inside one instance of IIB, we are packaging the app and IIB runtime into a unique container to deploy in pods and facilitate horizontal scaling. The vertical scaling delivered out of the box in IIB is not leveraged.

1. Deploy webapp to ICP [follows this tutorial](https://github.com/ibm-cloud-architecture/refarch-caseinc-app/blob/master/docs/run-icp.md)
1. Deploy Java application running on Liberty [read this tutorial](https://github.com/ibm-cloud-architecture/refarch-integration-dal/blob/master/icp/README.md))
1. Deploy IBM Integration Bus [read this tutorial](https://github.com/ibm-cloud-architecture/refarch-integration-esb/blob/master/IBMCloudprivate/README.md))
1. Deploy API Connect gateway from ICP Catalog using [this tutorial](https://github.com/ibm-cloud-architecture/refarch-integration-api/blob/master/docs/icp/README.md)
1. Deploy the api product to the new gateway.


## Cfg 5: All API Connect to ICP
This configuration runs every component on ICP, leverage public cloud service, and on-premise directory services.

![](./bc-icp-cfg5.png)


## Use ICP Catalog
A packaged application can be used as template for creating application. Using the ICP admin console you can get the list of repositories using the ** Admin > Repositories ** menu:

![](icp-repo.png)

Once the helm chart is packaged, a zip file is created and the publishing steps look like the following:

* copy the tfgz file to an HTTP server. (172.16.0.5 is a HTTP server running in our data center). Be sure to have write access to it.
```
$ scp casewebportal-0.0.1.tgz admin@172.16.0.5/storage/local-charts
```
* Then you need to update your private catalog index.yaml file.  The index file describes how your applications is listed in the ICP Application Center:
```
$ curl get -k https://9.19.34.107:8443/helm-repo/charts/index.yaml
$ helm repo index --merge index.yaml --url http://9.19.34.117:/storage/CASE/refarch-privatecloud ./
$ scp index.yaml admin@9.19.34.107:8443/helm-repo/charts
```

Once the repository are synchronized your helm chart should be in the catalog:
![](helm-in-app-center.png)


# Understanding networking
TBD
