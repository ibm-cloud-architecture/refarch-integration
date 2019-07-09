# Hybrid Integration Reference Architecture


The hybrid integration reference architecture can be depicted at the highest level as the following diagram:

![](fig1.png)

The on-premise capabilities are in the lower parts and most likely host the system of records (SoR), the lower level of connectivity like Java based SOA services, Integration BUS flows, BPEL flows, service orchestration. This level offers core, reusable business operations, applying the strong SOA patterns.
On top of this layer co-exist different IT capabilities, like asynchronous event based architecture, API composition and aggregation, and data synchronization, data movement. These capabilities offer a set of features for the 'digital team', who develops new cloud native applications. Those capabilities can run on-premise, on private cloud or even some of them on public cloud.

As part of the API economy those capabilities can be exposed as managed APIs with API and event gateway used to control API access, governance and monitoring. The can represent 'System APIs'.

When we develop new application on cloud, web apps or micro services is to support system of engagement business logic, meaning support specific business requirements for a specific business or technology channels. Those applications need to be developed quickly to address a new business opportunity. Cloud based development with scripting language, continuous deployment and integration, container, enables this quick around time for such development. Those micro services do not need to be just nodejs app, they can for sure being java based, but even micro flows in Integration Bus. They need to do service mash up, aggregation of API, data model transformation, asynchronous event consumptions  or emission. The deployment of these capabilities will reside on cloud based platform using container orchestration.

Those business functions can also be exposed via API managed with API gateway. They represent external APIs.

Finally at the top reside the client apps consumer of the system of engagement services.

## Hybrid integration platform

The following diagram presents the different hybrid integration patterns, you may find in modern IT where cloud native applications deployed on public cloud (top) can access on-premise resource deployed on IBM Cloud Private (ICP) or more traditional back end systems.
Modern enterprise IT has applications of engagement which typically reside on a public cloud since they are internet facing. These could be mobile, web or applications from business partners that consume external APIs published by the enterprise.

These APIs are exposed externally using a dedicated API Gateway for isolation and provide the required integration to enterprise backend systems.

While enterprise systems are usually considered as systems of record, the adoption of microservices within enterprise IT introduces a layer of separation between backend systems like Databases, ERP systems and application microservices. Applications that are traditionally considered as backend systems could be refactored as microservices for IT modernization. Microservices running on IBM Cloud Private ([ICP](./icp/README.md)) could have different requirements for integration to backend systems depending on their composition. Following are the integration patterns for applications running on ICP:

![](brown-scope.png)

* Application migrated to ICP connecting to backend systems using integration services running in backend layer.
* Applications and the required integration services are migrated to ICP. Multiple applications can share the integration services.
* Each microservice within an application has a dedicated integration service. This pattern would apply where the microservice and integration service are owned by the same team. The integration service can be shared by other microservices as well e.g integration service defines integration with a backend HR system. The integration services will follow the principles of lightweight integration - https://www.ibm.com/developerworks/cloud/library/cl-lightweight-integration-2/index.html
* Applications with decoupled microservices for robustness could use lightweight publish/subscribe messaging for inter-communication and call backend systems using internal APIs.
* Internal APIs are exposed using a dedicated API Gateway and consumed by internal applications.

The figure below zoom into the pattern of using micro services and application as a group of micro services to support the system of engagement. Those applications are exposing API to the external consumers (mobile app, Single page application) and consume internal / system APIs.

![](ms-itg-api.png)

Micro service component could also be used to improve the agility, scalability, and resilience of a system of record. They offer a lot of benefits on the right circumstances. 

These patterns provide integration architectures for modern enterprise applications as they progress through the IT modernization journey.  It is possible that a modern enterprise may have to use all the above integration patterns to meet the application requirements.
