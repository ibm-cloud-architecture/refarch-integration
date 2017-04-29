# Hybrid Integration Reference Architecture

# Architecture
This project provides a reference implementation for building hybrid application on the cloud using microservices architecture connected to enterprise data source running on-premise.
![High level view of the architecture](docs/hybrid-ra.png)

For information of the Hybrid architecture, visit the [Architecture Center - Hybrid Architecture](https://www.ibm.com/devops/method/content/architecture/hybridArchitecture#0_1)

# Project Repositories
This project leverages other projects by applying clear separation of concerns design, n-tiers architecture, and service oriented architecture.

* [Data Access Layer](https://github.com/jbcodeforce/refarch-premsource-inventory-dal) to deliver SOAP interface for Inventory management. JAXWS / JPA app.
* [DB2](https://github.com/jbcodeforce/refarch-premsource-inventory-db2) to support scripting and ddl for Inventory DB.
* [APIC Connect]() Content for the Inventory API definition and management


# Run the reference application locally and on IBM Bluemix
To run the sample application you will need to configure your Bluemix environment for the WebApp front end, and skytap environment...

## Step 1: Environment Setup
### Prerequisites

### Install the Bluemix CLI
As IBM Bluemix application, many commands will require the Bluemix CLI toolkit to be installed on your local environment. To install it, follow [these instructions](https://console.ng.bluemix.net/docs/cli/index.html#cli)

The following steps use the cf tool.

### Create a New Space in Bluemix

1. Click on the Bluemix account in the top right corner of the web interface.
2. Click Create a new space.
3. Enter "ra-hybrid-dev" for the space name and complete the wizard.

### Get application source code

Clone the base repository: ``` git clone https://github.com/jbcodeforce/refarch-premsource```

Clone the peer repositories: ./clonePeers.sh
