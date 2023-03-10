# Install OpenRMF in an Air-Gapped System

Given who this application is for, you may very well have a "disconnected from the Internet" type of setup. You can still use all these containers and such on that system. However, you will need to do a bit of work as outlined below. you also will still need the ZIP file contents from one of the releases that has the start scripts, docker-compose, Prometheus file, and initialization scripts. Including the .env file that has to have a pointer to the Keycloak server setup as well. 

> Note: you must have Docker and Docker Compose or Podman and Podman-Compose currently to run OpenRMF in this manner. The other option is to pull down individual APIs, Message Clients, MongoDB, NATS, Keycloak, Prometheus, Grafana, Jaeger and PostgreSQL to setup manually. That would be a PITA. But it can be done. Ask in our [Slack Channel](https://join.slack.com/t/openrmftool/shared_invite/zt-ck8lqld0-8LD7k66mzj7WsIno9YFrMg) for more information on that if we can help. 


## Getting the application container images downloaded
Follow these steps to at least have a running application locally. 

* on an Internet connection machine, run the "start.sh" from one of the OpenRMF release bundles
* this will run docker compose and pull all relevant software container images
* you can use the docker save -o xxxxxxxxxxx filename type of command to save the image to a local file, i.e. `docker save -o cingulara-webui.image cingulara/openrmf-web:1.0` to save the web UI image to a file named cingulara-webui.image
* do this for all the openrmf-xxxxx images listed below as well as the Mongo, Prometheus, Grafana, Jaeger, NATS images (if you do not want Jaeger, Prometheus and Grafana, comment them out in the docker-compose file on the new machine)
* Note, if you are using podman then substitute `podman` for `docker` and `podman-compose` for `docker compose` as well -- see [Minimum Requirements](./minimim-requirements.md) for more information.

## Loading the images on an air-gapped machine
Take all the image files from above and put onto a DVD / CD / USB (if allowed) and then copy them onto the air-gapped machine. Then follow these instructions. 

* on the airgapped machine you can run `docker load -i xxxxxxxxxxxx` on each *.image file to load that image file onto that machine into the local Docker registry
* after doing that on every single image required, run `docker images | more` to see that they all loaded correctly
* run the `./start.sh` on that airgapped machine

> Note: if the machine is connected to nothing, you may need to plug it into a disconnected switch just to have it sense a network connection. We have had to do this on a disconnected MacBook. And remember to set a manual IP address to use. Ensure Keycloak is setup to allow using that IP for the client setup. 

## Application Container Images you will need to have
For OpenRMF<sup>&reg;</sup> OSS (Please check the scripts/docker-compose.yml for the latest information.):
* cingulara/openrmf-web:1.09.01
* cingulara/openrmf-api-scoring:1.09.01
* cingulara/openrmf-api-template:1.09.01
* cingulara/openrmf-api-read:1.09.01
* cingulara/openrmf-api-compliance:1.09.01
* cingulara/openrmf-api-controls:1.09.01
* cingulara/openrmf-api-audit:1.09.01
* cingulara/openrmf-api-report:1.09.01
* cingulara/openrmf-msg-score:1.09.01
* cingulara/openrmf-msg-compliance:1.09.01
* cingulara/openrmf-msg-controls:1.09.01
* cingulara/openrmf-msg-template:1.09.01
* cingulara/openrmf-msg-system:1.09.01
* cingulara/openrmf-msg-audit:1.09.01
* cingulara/openrmf-msg-report:1.09.01
* cingulara/mongo:5.0.6-nonroot
* nats:2.8.1-alpine3.15
* synadia/prometheus-nats-exporter:0.6.2
* cingulara/nats-client-metrics:1.0.1
* prom/prometheus:v2.35.0
* grafana/grafana:8.5.0
* postgres:11.5
* cingulara/keycloak-openrmf:20.0.3

> The `cingulara/xxx` OpenRMF<sup>&reg;</sup> OSS items have the current version. Yours may differ in the container "tag" but not the name. 