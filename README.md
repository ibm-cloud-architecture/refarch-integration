# Hybrid Integration Reference Architecture

## Architecture
This project provides a reference implementation for building an hybrid integration solution, using cloud native web application, connected via IBM secure gateway to an enterprise inventory database running on-premise server. This compute model, called *brown compute*, represents existing SOA / Traditional IT landscape with product like ESB, BPM, Rule engine, Java based web service applications. One of the goal of this implementation is to reflect what is commonly found in IT landscape in 2017.



## Application Overview
The application is an extension of the "CASE.inc" retail store introduced in [cloud native](https://github.com/ibm-cloud-architecture/refarch-cloudnative) for internal users who want to manage the inventory items of the retail shops/warehouses. The data base is a simple inventory DB with products, supplier and stock information. A Data Access Layer component, based on JAXWS, produces a set of SOAP operations to be used as part of a SOA strategy define early 2004. With new team in place a new user interface is developed using Angular 2, nodejs/express on Bluemix, as a cloud foundry app, and with remote access to on-premise data source via IBM Secure Gateway. As part of the new IT strategy, the inventory SOAP operations are exposed as APIs using API Connect so it can be easily consumed as RESTful API. The component and physical deployment looks like the image below:
![Components and Physical view](docs/cp-phy-view.png)

* On the left side the Case Inc Portal app defines a set of user interface to manage Inventory elements, and use the Back-end For Front-end pattern. The nodejs/expressjs accesses the REST api exposed by API Connect via a Secure Gateway service on bluemix which acts as a proxy.
* APIC Connect, installed on-premise, is used as gateway to the different API run time and to do the interface mapping between the SOAP data access layer and the RESTful API exposed to the public applications.
* The connection is done via a gateway tunnel using IBM Secure Gateway Client on a dedicated server.
* The database is running on DB2 and is not directly accessed from API connect, but applying SOA principles, it is accessed via a Data Access Layer app.
* The Data Access Layer app is a JAXWS application running on WebSphere Liberty server.

It is important to note that the development approach on the back-end is to sue Service Oriented Architecture, with ESB pattern and SOAP interface.

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
The 'top of the iceberg' for this solution implementation is the Bluemix app 'Case Inc Portal' that offers accesses to the Inventory management and other features. The details on how to build and run this application is [here](https://github.com/ibm-cloud-architecture/refarch-caseinc-app)

To run the backend solution, we will deliver images for you to install on your servers... stay tuned, from now we are describing how each servers / code are configured in each of the specific github repository. We are using VmWare vSphere product to manage all the virtual machines.  
![vsphere](docs/vsphere.png)

To install:
* DB2 server read [this note](https://github.com/ibm-cloud-architecture/refarch-integration-inventory-db2#db2-installation)
* Liberty App server read [this article]()

### Prerequisites
* You need your own [github.com](http://github.com) account
* You need a git client code. For example for [Windows](https://git-scm.com/download/win) and for [Mac](https://git-scm.com/download/mac)
* Install [npm](https://www.npmjs.com/get-npm) and [nodejs](). Normally getting nodejs last stable version will bring npm too.
* You need to have a [Bluemix](http://bluemix.net) account, and know how to use cloud foundry command line interface to push to bluemix, the web application used to demonstrate the solution.
* Install the Bluemix CLI: As IBM Bluemix application, many commands will require the Bluemix CLI toolkit to be installed on your local environment. To install it, follow [these instructions](https://console.ng.bluemix.net/docs/cli/index.html#cli)
* Use virtual machine images

### Create a New Space in Bluemix

1. Click on the Bluemix account in the top right corner of the web interface.
2. Click Create a new space.
3. Enter a name like "ra-integration" for the space name and complete the wizard steps.

### Get application source code

Clone the base repository using git client:
```
git clone https://github.com/ibm-cloud-architecture/refarch-integration.git
```

Then under the refarch-integration folder use the command ``` ./clonePeers.sh ``` to clone the peer repositories of the 'Brown compute' solution.

And only for the first time use the ```./configureAll.sh``` script to perform the different dependency installations for the bluemix apps and other utilities.

### Working on your own
The script ``` ./fork-repos.sh``` should help you to fork all the repositories of this solution within your github account.

## Add a IBM Secure Gateway Service
To authorize the web application running on Bluemix to access the API Connect gateway running on on-premise servers (or any end-point on on-premise servers), we use the IBM Secure Gateway product and the bluemix Secure Gateway service: the configuration details and best practices can be found in this [article](https://github.com/ibm-cloud-architecture/refarch-integration-utilities/blob/master/docs/ConfigureSecureGateway.md)

## Contribute
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
