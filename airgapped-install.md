# Install OpenRMF in an Air-Gapped System

Given who this application is for, you may very well have a "disconnected from the Internet" type of setup. You can still use all these containers and such on that system. However, you will need to do a bit of work as outlined below. you also will still need the ZIP file contents from one of the releases that has the start scripts, docker-compose, Prometheus file, and initialization scripts. Including the .env file that has to have a pointer to the Keycloak server setup as well. 

> Note: you must have Docker and Docker Compose currently to run OpenRMF in this manner. The other option is to pull down individual APIs, Message Clients, MongoDB, NATS, Keycloak, Prometheus, Grafana, Jaeger and PostgreSQL to setup manually. That would be a PITA. But it can be done. Ask in our [Slack Channel](https://join.slack.com/t/openrmftool/shared_invite/zt-ck8lqld0-8LD7k66mzj7WsIno9YFrMg) for more information on that if we can help. 

## Getting the Keycloak images downloaded
Pull down all files in the [Keycloak scripts](scripts/keycloak/) directory and then run one of the setups (manual or automated). Launch with the `start.sh` type of script and your machine will download the required images. When done you can run `stop.sh` to stop the Keycloak stack. 

Follow the steps in the section just below to copy the keycloak and postgresql images to files to load on your other machine. The list of files required is at the bottom of this page. 

## Getting the application container images downloaded
Follow these steps to at least have a running application locally. 

* on an Internet connection machine, run the "start.sh" from one of the OpenRMF release bundles
* this will run docker-compose and pull all relevant software container images
* you can use the docker save -o xxxxxxxxxxx filename type of command to save the image to a local file, i.e. `docker save -o cingulara-webui.image cingulara/openrmf-web:0.12.12` to save the web UI image to a file named cingulara-webui.image
* do this for all the openrmf-xxxxx images listed below as well as the Mongo, Prometheus, Grafana, Jaeger, NATS images (if you do not want Jaeger, Prometheus and Grafana, comment them out in the docker-compose file on the new machine)

## Loading the images on an air-gapped machine
Take all the image files from above and put onto a DVD / CD / USB (if allowed) and then copy them onto the air-gapped machine. Then follow these instructions. 

* on the airgapped machine you can run `docker load -i xxxxxxxxxxxx` on each *.image file to load that image file onto that machine into the local Docker registry
* after doing that on every single image required, run `docker images | more` to see that they all loaded correctly
* run the `./start.sh` on that airgapped machine

> Note: if the machine is connected to nothing, you may need to plug it into a disconnected switch just to have it sense a network connection. We have had to do this on a disconnected MacBook. And remember to set a manual IP address to use. Ensure Keycloak is setup to allow using that IP for the client setup. 

## Application Container Images you will need to have
For Keycloak:
* postgres:11.5
* jboss/keycloak:7.0.0

> Keycloak 8 or 9 may also work but for now, we use 7.0. We will upgrade in the summer of 2020. 

For OpenRMF:
* cingulara/openrmf-web:0.13.01
* cingulara/openrmf-api-scoring:0.13.01
* cingulara/openrmf-api-save:0.13.01
* cingulara/openrmf-api-template:0.13.01
* cingulara/openrmf-api-upload:0.13.01
* cingulara/openrmf-api-read:0.13.01
* cingulara/openrmf-api-compliance:0.13.01
* cingulara/openrmf-api-controls:0.13.01
* cingulara/openrmf-api-audit:0.13.01
* cingulara/openrmf-msg-score:0.13.01
* cingulara/openrmf-msg-checklist:0.13.01
* cingulara/openrmf-msg-compliance:0.13.01
* cingulara/openrmf-msg-controls:0.13.01
* cingulara/openrmf-msg-template:0.13.01
* cingulara/openrmf-msg-system:0.13.01
* cingulara/openrmf-msg-audit:0.13.01
* mongo:4.0.5
* nats:2.1.2-linux
* synadia/prometheus-nats-exporter:latest
* prom/prometheus
* grafana/grafana
* jaegertracing/all-in-one:latest

> The OpenRMF items have the current version. Yours may differ in the container "tag" but not the name. 