---
layout: default
title: Run HTTPS
nav_order: 1000
---

# Running OpenRMF over HTTPS v HTTP

OpenRMF is setup to run locally on your local server, laptop, etc.  If you want to use that over a network you can use the Unprivileged NGINX container we setup for the OpenRMF Web UI to front your OpenRMF with HTTPS. You just need to have a few files for your certificate, update the docker-compose, update Keycloak for https, and then restart your stacks. See below for details. 

## Setup Your Certificate
If you have a certificate server or use an online certificate, generate the certificate and get the KEY and CRT file available to use from the local container. I put mine into an "ssl" folder and mounted that to the /etc/nginx/certs/ folder. See the "Mounting the Certificates" link at the bottom of this page. You can do this with self-signed certificates as well but you have to figure out how to get the backend APIs to validate them correctly. 

My setup involved making a key like the links at the bottom suggest, generating the snippets files, and then mounting them correctly.  I also had to modify my nginx.conf file I use to redirect 8080 to 8443, and include the snippets files and server_name as well. Again, see the NGINX links below as those folks do a great job explaining what I am talking on here. 

self-signed.conf example
```
ssl_certificate /etc/nginx/certs/ssl/certs/self-signed.crt;
ssl_certificate_key /etc/nginx/certs/ssl/private/self-signed.key;
```

ssl-params.conf example
```
ssl_protocols TLSv1.1 TLSv1.2;
ssl_prefer_server_ciphers on;
ssl_ciphers "EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH";
ssl_ecdh_curve secp384r1;
ssl_session_cache shared:SSL:10m;
ssl_session_tickets off;
ssl_stapling on;
ssl_stapling_verify on;
resolver 8.8.8.8 8.8.4.4 valid=300s;
resolver_timeout 5s;
add_header Strict-Transport-Security "max-age=63072000; includeSubdomains";
add_header X-Frame-Options DENY;
add_header X-Content-Type-Options nosniff;
ssl_dhparam /etc/nginx/certs/ssl/certs/dhparam.pem;
```

## Update the Docker Compose file
We use the unprivileged NGINX container, so you cannot use port 80 and port 443 as some of the online articles tell you. You can however make :8080 redirect to :8443 and that works perfectly fine. We have done that ourselves with self-signed certificates. You must also expose port 8443 in the docker-compose file to ensure the redirection of 8080 to 8443 works correctly.

In the top OpenRMF web container area I did this, as I had an "nginx" folder I made in where all my OpenRMF docker-compose files are. The snippets folder files also point to the ssl folder I have in the same root OpenRMF main folder I use. The ssl folder has the certs/ and private/ folders for the files I generated for my certificate to run the OpenRMF part as https.

```
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
      - ./nginx/snippets/:/etc/nginx/snippets/:ro
      - ./ssl/:/etc/nginx/certs/ssl/:ro
```

Also for EVERY SINGLE container that is an API (there are 9), I had to add this as volumes in the docker-comopse.yml file. This allows all APIs to validate the self-signed certificate if you do not want to use a valid CA. You also could use a valid CA to generate certs, OR add the valid CA in here for your certificate in a similar manner. I leave that exercise to you!
```
    volumes:
      - ./ssl/certs/self-signed.crt:/etc/ssl/certs/self-signed.crt.conf:ro
      - ./ssl/private/self-signed.key:/etc/ssl/private/self-signed.key.conf:ro
```

![OpenRMF SSL Setup](/assets/sslsetup.png)

## Update Keycloak
Your Keycloak should also be in HTTPS mode or the authentication mixture of using HTTP for Keycloak to log into an HTTPS site will not work. When your Keycloak is using HTTPS correctly, you can then add the https://xxxxxxxxxxxxxx:8443/* to the Valid Redirect URIs before you try to login with OpenRMF over https. If you do not you will get the "invalid redirect" message which is easy to fix by adding the URI. You also can set Realm Settings for OpenRMF to require SSL for external or for all client connections. 

You can go to the information to setup Keycloak for SSL, following the steps in https://www.keycloak.org/docs/latest/server_installation/#enabling-ssl-https-for-the-keycloak-server. I chose to front Keycloak with NGINX in a similar way to how I am fronting it for the OpenRMF pieces. That information is below. I used the same SSL certs and config files, but the nginx.conf was a little different.

### Keycloak docker-compose.yml file updates
I modified the docker-compose for Keycloak to add the nginx-unprivileged container and mounted the same snipps and certs used in OpenRMF. But my nginx.conf is a bit different.  The keycloak entry in this docker-compose.yml file just had the 9001 port mapping removed so Keycloak runs on 8080 internally.
```
services:
  keycloakproxy:
    image: nginxinc/nginx-unprivileged:1.18-alpine
    restart: always
    ports:
      - 9001:8443
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
      - ./nginx/snippets/:/etc/nginx/snippets/:ro
      - ./ssl/:/etc/nginx/certs/ssl/:ro
    networks:
      - keycloak-network
    depends_on:
      - keycloak

  keycloak: 
    image: jboss/keycloak:10.0.2
    restart: always
    ports:
      - 8080
```

### Keycloak NGINX configuration file
Replace the "xxx.xxx.xxx.xxx" with your IP address or name below. 

```
worker_processes 4;
 
pid /tmp/nginx.pid; # Changed from /var/run/nginx.pid

events { worker_connections 4096; }
 
http {
 
    sendfile on;
    client_max_body_size 60M;
    include /etc/nginx/mime.types;
    keepalive_timeout  65;
    proxy_http_version 1.1;

 
    # configure nginx server to redirect to HTTPS
    # server {
    #     listen       9001;
    #     server_name  xxx.xxx.xxx.xxx;
    #     return 302 https://$server_name:9001;
    # }
    
    server {
        listen 8443 ssl http2;
        server_name  xxx.xxx.xxx.xxx;
        include snippets/self-signed.conf;
        include snippets/ssl-params.conf;

        # # don't send the nginx version number in error pages and Server header
        server_tokens off;

        proxy_set_header        Host $host:9001;
        proxy_set_header        X-Real-IP $remote_addr;
        proxy_set_header        X-Real-IP $remote_addr;
        # proxy_set_header        X-Forwarded-For $host;
        proxy_set_header        X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header        X-Forwarded-Proto $scheme;
        
        location / {
            proxy_pass http://keycloak:8080;
            add_header X-Frame-Options "ALLOWALL";
        }
    }
}
```

## Putting it all together

When you have the files setup and mounted to the cert path, 8443 used and exposed in the docker-compose.yml file, setup Keycloak to use HTTPS fronted by NGINX (or natively if you wish), updated the .env file in the OpenRMF directory, updated the OpenRMF docker-compose.yml file, and updated your Valid Redirect URIs you can bring up the Keycloak stack and then the OpenRMF stack and test out your HTTPS configuration. It may still warn you "this is not a valid cert" if you did a self-signed cert. I did this and used Safari and said "it is OK" for this to work. Or you can add it to the list of valid certs in your machine if you wish. Chrome did not like the self-signed cert I did at first. 

This assumes your certificates are valid in your system. If you do the self-signed certificates you may have an issue with the backend APIs not validating your JWT because the https link in your .env file is not being used with a valid https certificate.

You may want to run the "docker-compose up" without the "-d" as is in the SH/CMD startup scripts for OpenRMF to see the logs printed to the screen in case you need to debug your connections. You also can run ` docker logs openrmf-web ` for listing the logs of the OpenRMF web UI in NGINX out to the screen to help you troubleshoot.

## Generating a Certificate

https://nickolaskraus.org/articles/how-to-create-a-self-signed-certificate-for-nginx-on-macos/

https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-on-centos-7

https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-in-ubuntu-16-04


## Mounting the Certificates into the NGINX Container

https://medium.com/faun/setting-up-ssl-certificates-for-nginx-in-docker-environ-e7eec5ebb418
