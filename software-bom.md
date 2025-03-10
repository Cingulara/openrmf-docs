# OpenRMF Software Bill of Materials

For OpenRMF we have a few components used to create the software. They are listed below just so you have it in case you need to get this approved or are going for an Authorization to Operate. The application runs in containers so mainly it is the container runtime you need. But the other technologies are included here as well. 

* Docker, Podman with podman-compose, Docker Desktop or Kubernetes with OCI-compliant runtime
* Keycloak 26.1.0 or higher
* .NET Core 8 runtime (for building if you want)
* NATS messaging server 2.x Linux server (in a container)
* NGINX 1.27 or higher
* Prometheus 2.55.x
* Grafana 10.x
* MongoDB 6.x

The architecture diagram is here: [Architecture](./architecture/README.md).