# Non Functional Requirements
In this section we are covering some of the non functional Requirements

## Table of contents
* [Security](#security)
* [Resiliency](#resiliency)
* [DevOps](./devops/README.md)



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
We do not plan to implement complex topology for the on-premise servers to support HA, mostly because of cost and time reason and the fact that it is covered a lot in different articles. For IBM Cloud Private read the following [ICP cluster HA article](https://github.com/ibm-cloud-architecture/refarch-privatecloud/blob/master/Resiliency/Configure_HA_ICP_cluster.md)
