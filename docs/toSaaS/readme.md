# Lift and shift of an integration solution
In this article we are detailing how to migrate part of the 'hybrid solution' based on MQ, DB2 and tWAS applications to a pure IBM Cloud deployment. The following diagram illustrates the starting environment:

![](SaaS-start.png)

where the components are:
* User interface is the current cloud native portal application done with Angular 6 and BFF with nodejs that we can deploy as a cloud foundry app, or as container on IBM Container service. (See [this project](https://github.com/ibm-cloud-architecture/refarch-caseportal-app) ).
* LDAP service for user authentication and role definition
* [Inventory data access layer](https://github.com/ibm-cloud-architecture/refarch-integration-inventory-dal) is a JEE app to expose SOAP interface implemented with JAXWS and JPA to support SOA service as data access layer to the inventory database. It is deployed to Traditional WebSphere Application Service (tWAS).
* [An inventory DB2](https://github.com/ibm-cloud-architecture/refarch-integration-inventory-db2) to persist items, suppliers and inventory data in DB2.
* [Item event producer]((https://github.com/ibm-cloud-architecture/refarch-mq-messaging) is a java application to simulate event created from warehouse about item added to an inventory in the given warehouse. This is an event sent as a message to a Queue defined in the MQ manager.
* An [event listener](https://github.com/ibm-cloud-architecture/refarch-mq-messaging) application implemented as a message driven bean deployed on tWAS. This application persists the date to the inventory database.

and the target environment will be using the same components but move DB, WAS app and MQ to IBM Cloud.

![](SaaS-endState.png)

The MQ layer is using one queue manager deploy on IBM cloud. The MDB listen to queue defined on queue manager on Cloud and use the Data Access Layer SOAP service to save the item.

## Db2 database migration
We are addressing this migration in [this note.](https://github.com/ibm-cloud-architecture/refarch-integration-inventory-db2/blob/master/docs/db2-cloud.md)

## Traditional WAS App lift and shift
We are using the same approach as detailed in [this tutorial.](https://github.com/ibm-cloud-architecture/refarch-jee/tree/master/static/artifacts/WASaaS-tWAS-tutorial) but we [adapt it](./twas/readme.md) for our purpose.

The application to migrate is in [the data access layer service for the inventory data base as defined in this repository](https://github.com/ibm-cloud-architecture/refarch-integration-inventory-dal).

For refresh our memory or for beginner we are providing how to configure the resources to access DB2 from WAS in [this note](twas-res.md). Once resources are configured we can deploy the war file using the admin console or with script: see the [note here for detail on how to deploy the war to WAS.](https://github.com/ibm-cloud-architecture/refarch-integration-inventory-dal/blob/master/docs/twas-deploy.md)


### Tooling
There are a set of tools available to assess application for migration:
* WebSphere Application Server Migration Toolkit https://developer.ibm.com/wasdev/downloads/#asset/tools-WebSphere_Application_Server_Migration_Toolkit: The migration toolkit provides Eclipse-based tools for WebSphere migration scenarios including Cloud migration, WebSphere version to version migration including WAS Liberty, and migration from third-party application servers.
* Videos and demos around toolingHow to use migration toolkit for Discovery, assessment& binary scan : https://www-01.ibm.com/support/docview.wss?uid=swg27008724&aid=11
* Getting started with WebSphere in the Cloud : https://developer.ibm.com/wasdev/docs/getting-started-websphere-cloud/
* Moving WebSphere Worklods to public Cloud : https://www.ibm.com/cloud/garage/tutorials/was_lift_shift/Learn how to use the public cloud as either the upgrade development and test environment for your WebSphere infrastructure or as your new permanent environment.
* Migrating your WebSphere configurations to Cloud: https://ibm.ent.box.com/s/vja6fm8u3mktw9v26x1glvayvv5vlzrq
* WebSphere Configuration migration tool for IBM Cloud : https://developer.ibm.com/wasdev/docs/websphere-config-migration-cloud/
* Moving applications to the cloud :https://developer.ibm.com/wasdev/docs/migration/

## MQ based messaging solution
The implementation of the messaging solution is done in [this repository.](https://github.com/ibm-cloud-architecture/refarch-mq-messaging)

From an architecture point of view when doing lift and shift of MQ solution you need to assess the followings:
*
