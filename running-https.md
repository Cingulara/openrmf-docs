# Get OpenRMF<sup>&reg;</sup> OSS Running Behind HTTPS

There are a few steps here to make this work:
* take a good backup / snapshot of your setup
* run `./stop.sh` to stop the software stack
* generate your server certificate
* combine your server cert and CA cert into a bundle
* get your unencrypted server key 
* setup the `nginx.conf` file to listen for 8443 with proper cert paths
* setup Keycloak to pass to internal KC behind NGINX over HTTPS
* run the `openrmf-web` on port 8443 to match the NGINX configuration
* run `./start.sh` to start the software stack
* ensure the `openrmf-web` is working correctly with `docker logs openrmf-web` and looking for errors


