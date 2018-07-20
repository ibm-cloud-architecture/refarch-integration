# IBM Cloud Private Knowledge Sharing
In this section we group assets related to ICP in the CASE organization.

## Table of Contents
* [Value Proposition](#value-propositions)
* [Kubernetes personal summary](https://jbcodeforce.github.io/#/studies)
* [Community Edition installation (for your own development environment)](./dev-env-install.md)
* [Enterprise Edition Installation](https://github.com/ibm-cloud-architecture/refarch-privatecloud/blob/master/Installing_ICp_on_prem.md)
* [Deployment tutorials](#deployments)
* [ISTIO service mesh](../istio/readme.md)
* [FAQ](faq.md)
* [CLI command summary](icp-cli.md)
* [Troubleshooting](troubleshooting.md)
* [ICP Further Readings](#icp-further-readings) Get an exhaustive view of the things you need to read.

# Value propositions
## Value proposition for container
Just to recall the value of using container for the cognitive application are the following:
* Docker ensures consistent environments from development to production. Docker containers are configured to maintain all configurations and dependencies internally.
* Docker containers allows you to commit changes to your Docker images and version control them. It is very easy to rollback to a previous version of your Docker image. This whole process can be tested in a few minutes.
* Docker is fast, allowing you to quickly make replications and achieve redundancy.
* Isolation: Docker makes sure each container has its own resources that are isolated from other containers
* Removing an app/ container is easy and won’t leave any temporary or configuration files on your host OS.
* Docker ensures that applications that are running on containers are completely segregated and isolated from each other, granting you complete control over traffic flow and management

## Value proposition for Kubernetes
Kubernetes is an open source system for automating the deployment, scaling, and management of containerized apps.
* high availability 24/7
* Deploy new version multiple times a day
* Standard use of container for apps and business services
* Allocates  resources and tools when applications need them to work
* Single-tenant Kubernetes clusters with compute, network and storage infrastructure isolation
* Automatic scaling of apps
* Use the cluster dashboard to quickly see and manage the health of your cluster, worker nodes, and container deployments.
* Automatic re-creation of containers in case of failures

## Value proposition for IBM Cloud Private
The goal is to match the power of public cloud platform with the security and control of your firewall. Based on Kubernetes it offers the same benefits of kubernetes and adds more services and integration with on-premise data sources and services. Most of IBM leading middleware products can run on ICP. ICP helps developers and operations team to optimize legacy application with cloud-enabled middleware, open the data center to work with cloud services using hybrid integration, and create new cloud-native applications using devops tools and polyglot programming languages. [See the IBM ICP product page](https://www.ibm.com/cloud/private)

# Deployments
* [Deploy the hybrid cloud integration ( e.g. 'browncompute') solution](icp-integration.md)
* [Deploying a CASE Portal web app developed with Angular and package with its BFF server side](https://github.com/ibm-cloud-architecture/refarch-caseportal-app/blob/master/docs/icp/README.md)
* [Deploying a Customer churn web app developed with Angular and package with its BFF server side](https://github.com/ibm-cloud-architecture/refarch-cognitive-analytics/blob/master/docs/code.md#icp-deployment)
* [Deploy the data access layer app done with JAXRS and packaged with WebSphere Liberty on ICP](https://github.com/ibm-cloud-architecture/refarch-integration-inventory-dal/blob/master/docs/icp/README.md)
* [Deploy IBM Integration Bus on ICP](https://github.com/ibm-cloud-architecture/refarch-integration-esb/blob/master/docs/icp/README.md)
* [Deploy API Connect 2018.* on ICP](https://github.com/ibm-cloud-architecture/refarch-integration-api/tree/master/docs/icp/README.md)
* [Deploy Operational Decision Management](https://github.com/ibm-cloud-architecture/refarch-integration/blob/master/docs/odm/README.MD)
* [Deploy Kafka on ICP](https://github.com/ibm-cloud-architecture/refarch-analytics/blob/master/docs/kafka/readme.md#install-kafka-on-icp)
* [Deploy IBM Event Stream (Based on Kafka) on ICP](https://github.com/ibm-cloud-architecture/refarch-analytics/blob/master/docs/kafka/readme.md#install-on-icp)
* [Deploy Cassandra on ICP](https://github.com/ibm-cloud-architecture/refarch-asset-analytics/blob/master/docs/cassandra/readme.md#deployment-on-icp)
* [Deploy Data Science Experience on ICP](https://github.com/ibm-cloud-architecture/refarch-analytics/blob/master/docs/ICP/README.md)
* [Deploy Db2 Warehouse Developer Edition to IBM Cloud Private](https://github.com/ibm-cloud-architecture/refarch-analytics/blob/master/docs/db2warehouse/README.md)
* [Deploy Mongo DB on ICP](https://github.com/ibm-cloud-architecture/refarch-icp-mongodb)
* [Deploy Asset management microservice deployment](https://github.com/ibm-cloud-architecture/refarch-asset-analytics/tree/master/asset-mgr-ms#deploy)
* [Deploy Asset Kafka consumer and injector to Cassandra](https://github.com/ibm-cloud-architecture/refarch-asset-analytics/tree/master/asset-consumer#build-and-deployment)
* [Deploy Dashboard backend for frontend](https://github.com/ibm-cloud-architecture/refarch-asset-analytics/tree/master/asset-dashboard-bff#deploy)

# ICP Further Readings
* [IBM ICP product page](https://www.ibm.com/cloud/private)
* [Kubernetes tutorial](https://kubernetes.io/docs/tutorials/)
* [Storage best practice](https://github.com/ibm-cloud-architecture/refarch-privatecloud/blob/master/ICp-Storage_best_practice.md)
* [ICP backup](https://github.com/ibm-cloud-architecture/icp-backup)
