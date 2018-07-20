# Use ISTIO for service mesh
In this article we are covering a quick summary of istio as deployed inside ICP and how to leverage it for supporting different operational use cases for the Asset predictive maintenance solution.

## Summary
The concepts are presented in the istio [main page](https://istio.io/docs/concepts/what-is-istio/overview/).
From the istio architecture the **control plane** includes **Pilot, Mixer and Citadel**, and is responsible for managing and configuring proxies to route traffic, and configuring Mixers to enforce policies and collect telemetry. The following is an example of pod assignment within ICP. Egress gateway and servicegraph run on a proxy, while the other components run in the worker nodes.

![](istio-icp-deploy.png)

*The command used to get this assignment are:*
```
$ kubectl get nodes
$ kubectl describe node <ipaddress>
```
To get the pods: `kubectl get pods -n istio-system`.

The component roles:  

| Component | Role |  
| ---- | ----- |  
|  **Envoy**  | Proxy to mediate  all inbound and outbound traffic for all services in the service mesh. It is deployed as a sidecar container inside the same pod as a service. |
| **Mixer** | Enforces access control and usage policies across the service mesh and collecting telemetry data from the Envoy proxy. |
| **Pilot** | Supports service discovery, traffic management, resiliency. |
| **Citadel** | Used for service-to-service and end-user authentication. Enforce security policy based on service identity. |
