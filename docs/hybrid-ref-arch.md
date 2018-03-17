# Hybrid Reference Architecture
The hybrid integration reference architecture can be depicted at the highest level as the following diagram:

![](fig1.png)

The on-premise capabilities are in the lower parts and most likely host the system of records (SoR), the lower level of connectivity like Java based SOA services, Integration BUS flows, BPEL flows, service orchestration. This level offers core, reusable business operations, applying the strong SOA patterns.
On top of this layer co-exist different IT capabilities, like asynchronous event based architecture, API composition and aggregation, and data synchronization, data movement. These capabilities offer a set of features for the 'digital team', who develops new cloud native applications. Those capabilities can run on-premise, on private cloud or even some of them on public cloud.

As part of the API economy those capabilities can be exposed as managed APIs with API and event gateway used to control API access, governance and monitoring. The can represent 'System APIs'.

When we develop new application on cloud, web apps or micro services is to support system of engagement business logic, meaning support specific business requirements for a specific business or technology channels. Those applications need to be developed quickly to address a new business opportunity. Cloud based development with scripting language, continuous deployment and integration, container, enables this quick around time for such development. Those micro services do not need to be just nodejs app, they can for sure being java based, but even micro flows in Integration Bus. They need to do service mash up, aggregation of API, data model transformation, asynchronous event consumptions  or emission. The deployment of these capabilities will reside on cloud based platform using container orchestration.

Those business functions can also be exposed via API managed with API gateway. They represent external APIs.

Finally at the top reside the client apps consumer of the system of engagement services.
