# Journey to the cloud
This article aims to present how to adopt the cloud leveraging the existing materials develop by IBM Cloud Architecture and Solution engineering team.

## Why Cloud?
The most important value points:
* Rapid deployment, scalability, ease of use, and elasticity to adapt to demand
* Predictable cost, optimized for workload demand
* Enable DevOps, increase developers productivity  

Private cloud adds:
* Knowledge of where data resides
* Apply own enterprise own security and governance policies
* Simplify integration to on-premise business functions

[IBM Public Cloud](https://www.ibm.com/cloud/) value proposition:
* Easy migration
* Adopt cloud native development and operations
* AI Ready
* Hybrid integration
* Secure: continuous security scanning for apps and data
* Easily integrate and manage all your data across vendors and clouds — on or off premises

Cloud is the technology for innovation and transformation. AI, blockchain, multi-cloud, SaaS integration, single page app are drivers for cloud adoption. The new application landscape integrate existing data centers, private cloud within corporate firewall and SaaS, Public cloud provider, IoT, traditional B2B...
The new landscape will be multi-cluster & multi-cloud.
<img src=new-app-landscape.png width=800px/>



IBM Cloud public offers a set of added value services to manage data, app development, devops, networking access, servers, security, AI, blockchain and more.... The [IBM Cloud service catalog is continuously updated](https://console.bluemix.net/catalog)


## [IBM Private Cloud reference architecture](https://www.ibm.com/cloud/garage/architectures/private-cloud)
IBM Cloud Private brings cloud innovation within your datacenter. It is a Kubernetes platform with optimized scheduling, with most of the IBM Middleware products moving to it and it:
* supports better cluster management, security capabilities, image repositories, routing services, and microservices mesh
* authorizes infrastructure automation with scripts (Terraform, [IBM Multi Cloud Manager](https://www.ibm.com/cloud/smartpapers/multicloud-management/))
* provides monitoring for container-based applications for logging, dashboards, and automation.
* supports network and storage policy-based controls for application isolation and security, and automated application health checking and recovery from failures

<img src=ICP-oneView.png width=800px/>

For product introduction see [ICP Product page here.](https://www.ibm.com/cloud-computing/products/ibm-cloud-private/)

With the [ICP catalog](https://169.47.77.137:8443/catalog) you can install a lot of IBM middleware products and some open sources and your own helm charts in few seconds.

<img src=icp-catalog.png width=800px/>

## Challenges to solve
We recognize that not every organization is ready to move everything they have to a public cloud environment, and there are lots of reasons for that. IBM offers the richest range of deployment options – from Private to Public and Dedicated. Still, enterprises will face new challenges in broadening the adoption of Cloud to critical applications. We can group those challenges into different categories and we will address in next sections the best practices and other product informations we have developed for you:
* Application [ARCHITECTURE and DEVELOPMENT](#architecture-and-development) practices:
  * What does it mean to adopt Microservice pattern
  * Lift and shift existing applications to cloud
  * Refactoring existing applications
  * Adopt polyglot with new Languages & runtimes
  * Engage with APIs management and API standard
  * DevOps, continuous delivery  
* Application [PORTABILITY](#portability)
  * Regulation and multi regions deployment
  * Cloud provider availability
  * Cost and quality of services  
* [INTEGRATION](#integration)
  * APIs definition & Management
  * Integrating existing Applications and SOA services
  * Support transactions
  * Leverage and coexist with existing ESB
  * Agility for new integration needs
* [DATA MOVEMENT & GOVERNANCE](#data-governance)
  * New Analytics & AI Services
  * Data Privacy & Risk
  * Data Gravity & Performance
  * Network Cost
  * Data Gravity & Lock-in
* [SERVICE MANAGEMENT](#service-management)
  * Monitoring/SRE
  * SLAs
  * Problem Diagnosis
  * HA/DR
  * Scale
  * Backup and restore
* [SECURITY](#security) & COMPLIANCE
  * Identity & Authorization
  * Audit
  * Shared Responsibility Models
  * Regulatory Compliance


*Operation lead (Todd), responsible for infrastructure management, security and environment availability and maintenance has different concerns than developer (Jane) who is responsible to develop new application but also maintain existing application.*

# A journey...
## Architecture and Development
#### [Microservice reference architecture](https://www.ibm.com/cloud/garage/architectures/microservices/0_0)
Microservices is an application architectural style in which an application is composed of many discrete, network-connected components
* [Microservices in the world of integration](https://github.com/ibm-cloud-architecture/refarch-integration/blob/master/docs/hybrid-itg-platform.md)
* Public cloud for dev and test
[Stock trader app to ICP and Public](https://www.youtube.com/watch?v=pM3oFNAH2dA&index=4&list=PLzpeuWUENMK37ZlLBc_pIlXlOWeGnYRA_)
* [Blue compute on kubernetes: a microservice reference implementation](https://github.com/ibm-cloud-architecture/refarch-cloudnative-kubernetes)

<img src="https://github.com/ibm-cloud-architecture/refarch-cloudnative-kubernetes/blob/master/images/bluecompute_ce.png" width=800px/>

#### Innovate quickly with cloud native development
Leverage the following tutorials and articles
* [Tutorial: Deploy a cloud-native application in Kubernetes](https://www.ibm.com/cloud/garage/demo/try-private-cloud-install-an-app)
* [Microservices with Kubernetes](https://www.ibm.com/cloud/garage/architectures/microservices/microservices-kubernetes)
* [An Angular 6 SPA with nodejs bff full app](https://github.com/ibm-cloud-architecture/refarch-caseportal-app)
* [Run the Springboot on a Kubernetes Cluster](https://github.com/ibm-cloud-architecture/refarch-cloudnative-spring)
* [Making Microservices Resilient](https://github.com/ibm-cloud-architecture/refarch-cloudnative-resiliency/)
* [Use Microclimate to run an End-to-End DevOps environment on IBM Cloud Private](https://github.com/ibm-cloud-architecture/refarch-cloudnative-bluecompute-microclimate)

#### Refactoring app to microservices
Business wants to improve the application to increase client adoption and satisfaction. Monolithic applications are more difficult to change and moving to microservice architecture will bring velocity to the development team.

* [Refactoring application code to microservices](https://www.ibm.com/cloud/garage/content/code/refactor-to-microservices), this article addresses the why and how to refactor an existing Java application to microservice architecture. They also cover data model refactoring
* [The process to start from an existing JEE to split into microservices is documented in this repository](https://github.com/ibm-cloud-architecture/refarch-jee). 10-15% of existing WebSphere workloads can be moved as-is to cloud.
* [WebSphere on the Cloud: Application Modernization](https://www.ibm.com/blogs/bluemix/2017/08/websphere-on-the-cloud-application-modernization/)


#### Polyglot applications
Use one the available [boiler plates, starting](https://console.bluemix.net/developer/appservice/starter-kits) code from IBM Cloud like Nodejs, Java, Python, GoLang, Swift...
and deploy them on ICP or IBM Container services.
Below is a list of how to guides for Java and nodejs app but also decision and event streaming:
* [Develop a SOAP Jaxws app deployed in OpenLiberty and docker](https://github.com/ibm-cloud-architecture/refarch-integration-inventory-dal)
* [Apply a test driven development for Angular 6 app with nodejs-expressjs BFF service](https://github.com/ibm-cloud-architecture/refarch-caseportal-app/blob/master/docs/tdd.md)
* [Event messaging with Apache Kafka in kubernetes](https://github.com/ibm-cloud-architecture/refarch-analytics/blob/master/docs/kafka/readme.md)
* [Develop a REST API with JAXRS](https://github.com/ibm-cloud-architecture/refarch-integration-services)
* [How to develop a REST API which integrates with a SOAP backend](https://github.com/ibm-cloud-architecture/refarch-integration-esb/tree/master/docs/tutorial)
* [Implement decisions with  Operational Decision Management](https://github.com/ibm-cloud-architecture/refarch-cognitive-prod-recommendations) and [deploy ODM on ICP](https://github.com/ibm-cloud-architecture/refarch-integration/blob/master/docs/odm/README.MD)


#### Lift and shift
A need to shift from IaaS (VM, network, storage, security) to container and CaaS (kubernetes) and PaaS (cloud foundry).
* Java based lift and shift
 A Traditional JEE app running on WebSphere Application server can be lift and shift to WAS on IBM Cloud. The [Inventory Data Access Layer](https://github.com/ibm-cloud-architecture/refarch-integration-inventory-dal) is a JaxWS application exposing a SOAP APIs. The figure below shows the deployed app in the IBM console   
 ![](https://github.com/ibm-cloud-architecture/refarch-integration-inventory-dal/blob/master/docs/twas/wasnd-deploy-8.png).  
 The application is accessing a DB2 via JDBC. [Deployment explanation on tWAS](https://github.com/ibm-cloud-architecture/refarch-integration-inventory-dal/blob/master/docs/twas/readme.md)
 We are presenting how to move an integration solution to IBM Cloud in this article: [Lift and shift of an integration solution](https://github.com/ibm-cloud-architecture/refarch-integration/tree/master/docs/toSaaS).

 With a deep dive Java EE migration path in [this repository](https://github.com/ibm-cloud-architecture/refarch-jee/blob/master/phases/phase1.md)

 A [migration strategy tool](http://whichwas.mybluemix.net/) to support your migration scoping, with the [WebSphere Application Server V9 Total Cost of Ownership Calculator](https://roi-calculator.mybluemix.net/).

 The Transformation Advisor application [deployable on ICP](https://ibm-dte.mybluemix.net/ibm-websphere-application-server-cloud-enabled) helps to quickly evaluate your on-premise applications for rapid deployment on WebSphere Application Server and Liberty on Public and/or Private Cloud environments.

 [The Migration Toolkit for Application Binaries](https://developer.ibm.com/wasdev/downloads/#asset/tools-Migration_Toolkit_for_Application_Binaries) provides a command line tool that quickly evaluates application binaries for rapid deployment on newer versions of WebSphere Application Server traditional or Liberty.

 Finally the [source migration toolkit](https://developer.ibm.com/wasdev/downloads/#asset/tools-WebSphere_Application_Server_Migration_Toolkit) is an Eclipse-based Migration Toolkit provides a rich set of tools that help you migrate applications from third-party application servers, between versions of WebSphere Application Server, to Liberty, and to cloud platforms.

* MQ lift and shift  
We are presenting some [simple implementation](https://github.com/ibm-cloud-architecture/refarch-mq-messaging) using MQ on premise with Message Driven Bean deployed on WAS and a lift and shift path to [MQ on IBM Cloud](https://www.ibm.com/cloud/mq) in [this note]()
The benefits to run MQ on cloud is that you keep your skill set but use cloud speed to:
  * Create queue manager in minute
  * Get product upgrade and patch done by IBM
  * Pay as you use.
  * Integrate with MQ manager on premise.  

* DB2 lift and shift
[We are presenting different approaches ](https://github.com/ibm-cloud-architecture/refarch-integration-inventory-db2/blob/master/docs/db2-cloud.md) to migrate DB2 database to DB2 on cloud.

* Message Broker / IBM Integration Bus  

  * [How an IBM Integration Bus runtime can be deployed on premise or on IBM Cloud Private, running gateway flows to expose REST api from SOAP back end services](https://github.com/ibm-cloud-architecture/refarch-integration-esb)

  * [Deploying IIB Application using Docker locally](https://github.com/ibm-cloud-architecture/refarch-integration-esb/tree/master/docs/deploy)

  * [Build IBM Integration Bus Helm Chart suitable for IBM Cloud Private](https://github.com/ibm-cloud-architecture/refarch-integration-esb/tree/master/docs/helm) and [deploy it to ICP](https://github.com/ibm-cloud-architecture/refarch-integration-esb/tree/master/docs/icp)


#### API management
* [How we define an API product with IBM API Connect to integrate an existing SOA service](https://github.com/ibm-cloud-architecture/refarch-integration-api)
* [Deploy API Connect 2018.* on ICP](https://github.com/ibm-cloud-architecture/refarch-integration-api/tree/master/docs/icp/README.md)


#### Devops
* [DevOps for Cloud Native Reference Application](https://github.com/ibm-cloud-architecture/refarch-cloudnative-devops-kubernetes)
* [Hybrid integration solution CI/CD](https://github.com/ibm-cloud-architecture/refarch-integration/blob/master/docs/devops/README.md)
* [Tutorial to install and configure a Jenkins server that uses a persistent storage volume on IBM Cloud Private](https://www.ibm.com/cloud/garage/tutorials/cloud-private-jenkins-pipeline)
* [Use Jenkins in a Kubernetes cluster to continuously integrate and deliver on IBM Cloud Private](https://www.ibm.com/cloud/garage/content/course/cloud-private-jenkins-devops/0)
* [Devops for API deployment](https://www.ibm.com/cloud/garage/videos/efficient-api-deployment-with-devops-governance)

## Portability
#### [Private cloud reference architecture](https://www.ibm.com/cloud/garage/architectures/private-cloud)
#### [Backup and restore on IBM cloud Private](https://github.com/ibm-cloud-architecture/icp-backup)
A guidance to backup and recovery procedures to best meet your resilience requirements, in the context of kubernetes cluster using ETCD.
#### [Using Terraform to deploy ICP on different Cloud providers](https://github.com/ibm-cloud-architecture/terraform-module-icp-deploy)
#### [Federating ICP  on-premise clusters](https://github.com/ibm-cloud-architecture/refarch-privatecloud/blob/master/Resiliency/Federating_ICP_clusters.md)

<img src="https://github.com/ibm-cloud-architecture/refarch-privatecloud/blob/master/Resiliency/images/icp_federation.png" width=800px/>

## Integration
Leveraging existing investments and in-production services with new cloud native and mobile applications. Transforming SOAP and other interface to RESTful API.
<img src="https://github.com/ibm-cloud-architecture/refarch-integration/blob/master/docs/brown-scope.png" width=800px/>

#### [The reference architecture for hybrid cloud](https://www.ibm.com/cloud/garage/architectures/integrationServicesDomain)
 Enables cloud applications and services to have a tighter coupling with specific on-premises enterprise system components.
#### [Hybrid integration solution implementation ](https://github.com/ibm-cloud-architecture/refarch-integration) presents a deep dive implementation using API Connect, MQ, WAS application, Cloud native web application, DB2, ODM, BPM, and IIB...
#### [IBM Cloud private knowledge sharing](https://github.com/ibm-cloud-architecture/refarch-integration/tree/master/docs/icp)
#### [How an IBM Integration Bus runtime can be deployed on premise or on IBM Cloud Private, running gateway flows to expose REST api from SOAP back end services](https://github.com/ibm-cloud-architecture/refarch-integration-esb)
#### [Tutorial provides a guided walkthrough of the IBM MQ on Cloud service in IBM Cloud](https://www.ibm.com/cloud/garage/tutorials/ibm-mq-on-cloud/tutorial-mq-on-ibm-cloud)

## Data governance
The IBM AI Ladder also begins with data. You get higher business value when you perform business-assisted functions such as analytics, machine learning, or artificial intelligence on top of the data...
<img src="https://github.com/ibm-cloud-architecture/refarch-analytics/blob/master/docs/data-mv-meth.png" width=800px/>

#### [Data Analytics reference architecture](https://www.ibm.com/cloud/garage/architectures/dataAnalyticsArchitecture)

<img src="https://github.com/ibm-cloud-architecture/refarch-analytics/blob/master/docs/analytics-ra.png" width=800px/>

#### [Data Analytics solution implementation](https://github.com/ibm-cloud-architecture/refarch-analytics) This project provides a reference implementation for building and running analytics application deployed on hybrid cloud environment. Two sub projects are under development to leverage [ICP for Data]()
 *[Customer analysis with cognitive and analytics in hybrid cloud](https://github.com/ibm-cloud-architecture/refarch-cognitive-analytics) The goal of this implementation is to deliver a reference implementation for data management and service integration to consume structured and unstructured data to assess customer attrition.
 <img src="https://github.com/ibm-cloud-architecture/refarch-cognitive-analytics/blob/master/docs/syst-ctx-2.png" width=800px/>

 * [Manufacturing Asset Predictive Maintenance](https://github.com/ibm-cloud-architecture/refarch-asset-analytics) This set of projects presents an end to end solution to enable predictive maintenance capabilities on manufacturing assets

#### [Deploying Cassandra on kubernetes](https://github.com/ibm-cloud-architecture/refarch-asset-analytics/blob/master/docs/cassandra/readme.md)

## Service management
#### [Reference Architecture @ IBM Garage method](https://www.ibm.com/cloud/garage/architectures/serviceManagementArchitecture/referenceArchitecture)

#### [Hybrid cloud management](https://www.ibm.com/cloud/smartpapers/multicloud-management/)
Hybrid, multicloud world is quickly becoming the new normal for enterprise.

#### [Monitoring in IBM Cloud Private](https://github.com/ibm-cloud-architecture/CSMO-ICP)
A set of artifacts created by the IBM CSMO team to assist you with performance management of your ICP deployment.

#### CSMO for cloud native application
[Leveraging Grafana, prometheus](https://github.com/ibm-cloud-architecture/refarch-cloudnative-kubernetes-csmo)

#### [A Sample Tools Implementation of Incident Management Solution](https://github.com/ibm-cloud-architecture/refarch-cloudnative-csmo/blob/master/doc/Incident_Management_Implementation.md)
A set of tools to provide an end-to-end view of application.
#### HA/DR
* [Making Microservices Resilient](https://github.com/ibm-cloud-architecture/refarch-cloudnative-resiliency/)
* [Guidance on HA ICP Cluster Setup](https://github.com/ibm-cloud-architecture/refarch-privatecloud/blob/master/Resiliency/Configure_HA_ICP_cluster.md)
<img src="https://github.com/ibm-cloud-architecture/refarch-privatecloud/blob/master/Resiliency/images/icp_ha_glusterfs.png" width=800px/>
#### [ICP Installation on Ubuntu](https://github.com/ibm-cloud-architecture/refarch-privatecloud/blob/master/Installing_ICp_on_prem_ubuntu.md)
## Security


## Cloud Architecture Solution Engineering [Assets list](https://ibm-cloud-architecture.github.io/)
