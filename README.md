# Hybrid Integration Reference Architecture

This project provides a reference implementation for building and running an hybrid integration solution, using cloud native web application securely connected to an enterprise data source and SOA service running on-premise servers. This compute model, called **Brown compute**, represents existing SOA / Traditional IT landscape with products such as ESB, BPM, Rule engine, and Java based web service applications. One of the goal of this implementation is to reflect what is commonly found in IT landscape in 2017, and provides recommendation on how to manage such hybrid architecture.

## Table of content
* [Application Overview](https://github.com/ibm-cloud-architecture/refarch-integration#application-overview)
* [Project Repositories](https://github.com/ibm-cloud-architecture/refarch-integration#project-repositories)
* [Run the Brown Compute model](https://github.com/ibm-cloud-architecture/refarch-integration#run-this-reference-application-locally-and-on-ibm-bluemix)
 * [Step 1: Environment Setup](https://github.com/ibm-cloud-architecture/refarch-integration#step-1:-environment-setup)
 * [Step 2: Provision Kubernetes Cluster on IBM Bluemix](https://github.com/ibm-cloud-architecture/refarch-integration)
 * [Step 3: Deploy and run](https://github.com/ibm-cloud-architecture/refarch-integration)
* [DevOps automation, Resiliency and Cloud Management and Monitoring](https://github.com/ibm-cloud-architecture/refarch-integration)
* [Contribute to the solution](https://github.com/ibm-cloud-architecture/refarch-integration#contribute)

## Application Overview
The front end business application is an extension of the "CASE.inc" retail store introduced in [cloud native](https://github.com/ibm-cloud-architecture/refarch-cloudnative) but dedicated for internal users who want to manage the inventory items of the retail shops/warehouses or wants to access other internal application. The data base is a simple inventory DB with products, supplier and stock information.

The end users will be able to authenticate to an internal LDAP, and access different capabilities like the **Inventory Plus** application manage items to resell on the public web page. To read a demonstration flow see the note [here](docs/brown-demo-flow.md)

A Data Access Layer component, based on JAXWS, produces a set of SOAP operations to be used as part of a SOA strategy defined early 2004. With new team in place a new user interface is developed using Angular 2, nodejs/express on Bluemix or on private cloud, as a containized nodejs app, and with remote access to on-premise data source via IBM Secure Gateway. As part of the new IT strategy, the inventory SOAP operations are exposed as RESTful APIs using API Connect so it can be easily consumed.

The component view and physical deployment looks like the image below:
![Components and Physical view](docs/cp-phy-view.png)

* On the left side the Case Inc Portal app defines a set of user interface to manage Inventory elements, and use the Back-end For Front-end pattern. The nodejs/expressjs accesses the REST api exposed by API Connect via a Secure Gateway service on bluemix which acts as a proxy. This application is containized and deployable on Kubernetes cluster.
* APIC Connect, installed on-premise, is used as gateway to the different API run time and to do the interface mapping between the SOAP data access layer and the RESTful API exposed to the public applications.
* The connection is done via a gateway tunnel using IBM Secure Gateway Client on a dedicated server. This server is called *BrownUtilityServer*.
* The database is running on DB2 and is not directly accessed from API connect, but applying SOA principles, it is accessed via a Data Access Layer app. The server is *BrownDB2*
* The Data Access Layer app is a JAXWS application running on WebSphere Liberty server. The server is *BrownLibertyAppServer*.

It is important to note that the development approach on the back-end is to use Service Oriented Architecture, with ESB pattern and SOAP interface.

For information of the Hybrid architecture, visit the [Architecture Center - Hybrid Architecture](https://www.ibm.com/devops/method/content/architecture/hybridArchitecture#0_1) with some light changes in the diagram as illustrated below:  
![RA](docs/hybrid-ra.png)

## Project Repositories
This project leverages other projects by applying clear separation of concerns design, n-tiers architecture, and service oriented architecture.

* [Data Access Layer](https://github.com/ibm-cloud-architecture/refarch-integration-inventory-dal) to deliver SOAP interface for Inventory management. JAXWS / JPA app.
* [DB2](https://github.com/ibm-cloud-architecture/refarch-integration-inventory-db2) to support scripting and ddl for Inventory DB.
* [APIC Connect](https://github.com/ibm-cloud-architecture/refarch-integration-api) Content for the Inventory API definition and management
* [Testing](https://github.com/ibm-cloud-architecture/refarch-integration-tests) This repository includes a set of test cases to do component testing, functional testing and integration tests.
* [Case Inc Internal Portal](https://github.com/ibm-cloud-architecture/refarch-caseinc-app) Portal web app to expose access and user interface for inventory DB.
* [Utility Server](https://github.com/ibm-cloud-architecture/refarch-integration-utilities) Server to manage a set of other components used for DevOps or connection like the secure gateway client.


## Run this reference application locally and on IBM Bluemix
The 'top of the iceberg' for this solution implementation is the Bluemix app 'Case Inc Portal' that offers accesses to the Inventory management and other features such as chatbots. The details on how to build and run this application is [detailed in this repository](https://github.com/ibm-cloud-architecture/refarch-caseinc-app)

To run the backend solution, we will deliver images for you to install on your servers... stay tuned, from now we are describing how each servers / code are configured in each of the specific github repository. We are using VmWare vSphere product to manage all the virtual machines. The figure below present the *Brown* Resource Pool.
![vsphere](docs/vsphere.png)


### Step 1: Environment Setup
#### Prerequisites
* You need your own [github.com](http://github.com) account
* You need a git client code. For example for [Windows](https://git-scm.com/download/win) and for [Mac](https://git-scm.com/download/mac)
* Install [npm](https://www.npmjs.com/get-npm) and [nodejs](). Normally getting nodejs last stable version will bring npm too.
* You need to have a [Bluemix](http://bluemix.net) account, and know how to use cloud foundry command line interface and blumix container CLI to push to bluemix, the containized web application used to demonstrate the solution.
* Install the different CLI needed: bluemix, cf, and kubernetes, we deliver for you a script for that see `./install_cli.sh`
* You need to have some knowledge on using virtual machine images and tool like vSphere. As an extension of this compute model we will add lift and shift to Bluemix.

#### Create a New Space in Bluemix

1. Click on the Bluemix account in the top right corner of the web interface.
2. Click Create a new space.
3. Enter a name like "ra-integration" for the space name and complete the wizard steps.

#### Get application source code

Clone the base repository using git client:
```
git clone https://github.com/ibm-cloud-architecture/refarch-integration.git
```

Then under the refarch-integration folder use the command ``` ./clonePeers.sh ``` to clone the peer repositories of the 'Brown compute' solution.

And only for the first time use the ```./configureAll.sh``` script to perform the different dependency installations for the bluemix apps and other utilities.

#### Working on your own
The script ` ./fork-repos.sh` should help you to fork all the repositories of this solution within your github account.

#### The Current Physical Deployment and Installation
The  Current Physical deployment includes six servers, we are describing how installation was done in each matching project so you can replicate the configuration. It should take you 2 to 3 hours per server.
* DB2 server read [this note](https://github.com/ibm-cloud-architecture/refarch-integration-inventory-db2#db2-installation)
* Liberty App server read [this article](https://github.com/ibm-cloud-architecture/refarch-integration-inventory-dal/blob/master/docs/liberty-server.md)
* API Connect see [Server config](https://github.com/ibm-cloud-architecture/refarch-integration-api#server-configuration)
* For LDAP Server running on the utility server []()
* Utility Server running Secure Gateway and Jenkins server[]()
As part of the Brown compute mission is to leverage the VM lift and shift approach by deploying vm image to Bluemix VM.

#### Add a IBM Secure Gateway Bluemix Service
To authorize the web application running on Bluemix to access the API Connect gateway running on on-premise servers (or any end-point on on-premise servers), we use the IBM Secure Gateway product and the bluemix Secure Gateway service: the configuration details and best practices can be found in this [article](https://github.com/ibm-cloud-architecture/refarch-integration-utilities/blob/master/docs/ConfigureSecureGateway.md)

### Step 2: Provision Kubernetes Cluster on IBM Bluemix
The kubernetes cluster is optional as the Case Inc Portal app can run in a docker container or as a cloud foundry application. We still encourage to use Kebernetes to deploy microservices as it offers a lot of added values we need. So if you want to deploy to Kubernetes you need to do the following instructions:
```
$ bx login
$ bx cs init
```
### Step 3: Deploy and run
<>
# DevOps automation, Resiliency and Cloud Management and Monitoring
* DevOps
You can setup and enable automated CI/CD for most of the *Brown Compute* components using Jenkins and Urban Code Deploy deploy on-premise. For detail, please check the DevOps project .

* Cloud Management and monitoring
For guidance on how to manage and monitor the *Brown Compute* solution, please check the Management and Monitoring project.

* Making the Portal App Resilient
Please check this repository on instructions and tools to improve availability and performances of the *Brown Compute* front end application.

* Secure The Application
Please review this page on how we secure the solution end-to-end.

# Contribute
We welcome your contribution. There are multiple ways to contribute: report bugs and improvement suggestion, improve documentation and contribute code.
We really value contributions and to maximize the impact of code contributions we request that any contributions follow these guidelines
* Please ensure you follow the coding standard and code formatting used throughout the existing code base
* All new features must be accompanied by associated tests
* Make sure all tests pass locally before submitting a pull request
* New pull requests should be created against the integration branch of the repository. This ensures new code is included in full stack integration tests before being merged into the master branch.
* One feature / bug fix / documentation update per pull request
* Include tests with every feature enhancement, improve tests with every bug fix
* One commit per pull request (squash your commits)
* Always pull the latest changes from upstream and rebase before creating pull request.

If you want to contribute, start by using git fork on this repository and then clone your own repository to your local workstation for development purpose. Add the up-stream repository to keep synchronized with the master.
