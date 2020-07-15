---
layout: default
title: Run HTTPS
nav_order: 1000
---

# Running OpenRMF over HTTPS v HTTP

You can use the Unprivileged NGINX container used for the OpenRMF Web UI to front your OpenRMF with HTTPS. You just need to have a few files for your certificate, update the docker-compose, and then restart your stack. See below for details. 

## Setup Your Certificate
If you have a certificate server or use an online certificate, generate the certificate and get the KEY and CRT file available to use from the local container. I put mine into an "ssl" folder and mounted that to the /etc/nginx/certs/ folder. See the "Mounting the Certificates" link at the bottom of this page. 

## Update the Docker Compose file
We use the unprivileged NGINX container, so you cannot use poret 80 and port 443 as some of the online articles tell you. You can however make :8080 redirect to :8443 and that works perfectly fine. We have done that ourselves with self-signed certificates. You must also expose port 8443 in the docker-compose file to ensure the redirection of 8080 to 8443 works correctly.

## Update Keycloak
Your Keycloak should also be in HTTPS mode or the authentication mixture of using HTTP for Keycloak to log into an HTTPS site will not work. When your Keycloak is using HTTPS correctly, you can then add the https://xxxxxxxxxxxxxx:8443/* to the Valid Redirect URIs before you try to login. You also can set Realm Settings for OpenRMF to require SSL for external or for all client connections. See the Keycloak documentation for more on that. 

## Putting it all together

When you have the files setup and mounted to the cert path, 8443 used and exposed in the docker-compose.yml file, setup Keycloak to use HTTPS, updated the .env file in the OpenRMF directory, and updated your Valid Redirect URIs you can bring up the Keycloak stack and then the OpenRMF stack and test out your HTTPS configuration.

You may want to run the "docker-compose up" without the "-d" as is in the SH/CMD startup scripts for OpenRMF to see the logs printed to the screen in case you need to debug your connections.


## Generating a Certificate

https://nickolaskraus.org/articles/how-to-create-a-self-signed-certificate-for-nginx-on-macos/

https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-on-centos-7

https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-16-04


## Mounting the Certificates into the NGINX Container

https://medium.com/faun/setting-up-ssl-certificates-for-nginx-in-docker-environ-e7eec5ebb418
