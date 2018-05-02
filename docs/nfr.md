# Non Functional Requirements
In this section we are covering some of the non functional Requirements

## Table of contents
* [Security](#security)
* [Resiliency](#resiliency)
* [DevOps](./devops/README.md)
* [Service Management](./csmo/README.md)

## Security
Multiple security concerns are addressed by the **hybrid integration compute** model. The first one is to support the deployment of private on-premise LDAP directory. The installation and configuration of the Open LDAP on the **Utility server** is described [here](https://github.com/ibm-cloud-architecture/refarch-integration-utilities#ldap-configuration).

Second, to control the access from a IBM Cloud app, we first implemented an adhoc solution integrating passport.js and using a /login path defined in our inventory product in API Connect. See explanation [here](https://github.com/ibm-cloud-architecture/refarch-caseinc-app/blob/master/docs/login.md#api-definition-on-back-end) on how we did it.  
The connection between the web app, front end of **hybrid integration compute** and the back end is done over TLS socket, we present a quick summary of TLS and how TLS end to end is performed in [this article](https://github.com/ibm-cloud-architecture/refarch-integration/blob/master/docs/TLS.md)

The front end login mechanism on how we support injecting secure token for API calls is documented [here](https://github.com/ibm-cloud-architecture/refarch-caseinc-app/blob/master/docs/login.md)

### Add a IBM Secure Gateway IBM Cloud Service
To authorize the web application running on IBM Cloud to access the API Connect gateway running on on-premise servers (or any end-point on on-premise servers), we use the IBM Secure Gateway product and the IBM Cloud Secure Gateway service: the configuration details and best practices can be found in this [article](https://github.com/ibm-cloud-architecture/refarch-integration-utilities/blob/master/docs/ConfigureSecureGateway.md)

## Resiliency
* Making the Portal App Resilient   
Please check [this repository](https://github.com/ibm-cloud-architecture/refarch-caseinc-app) for instructions and tools to improve availability and performances of the *hybrid integration Compute* front end application.

### High availability
We do not plan to implement complex topology for the on-premise servers to support HA, mostly because of cost and time reason and the fact that it is covered a lot in different articles.
For a basic introduction of HA and DR in a two or three data center you can read [this article](https://cloudcontent.mybluemix.net/cloud/garage/content/manage/hadr-on-premises-app/).

For IBM Cloud Private read the following [ICP cluster HA article](https://github.com/ibm-cloud-architecture/refarch-privatecloud/blob/master/Resiliency/Configure_HA_ICP_cluster.md)

Using container helps to control the server and OS configuration with the application code in a unique integrated deployment unit. This is a huge advantage for high availability of those applications. With modern single page application for web application, the micro services are more stateless and so the complexity of high availability between data center resides in the following areas:
* code replication as part of the continuous deployment
* data replication for the different datasource, SQL, non SQL and files. The different type of data may lead to different RPO and even loss tolerance. May be loosing, a tweet, a comment, or the picture of the aunt's cat are not that important, while a sale or bank transactions are.
* load balancing at the edge services
* number of instances for each of the different component of the solution. Is it possible to have at least three instances for each micro service running in parallel.  
* network latency
* security token management
