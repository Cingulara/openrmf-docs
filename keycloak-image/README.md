# Build your own Keycloak Optimized Container Image

https://www.keycloak.org/server/containers

We of course need to add in our theme and such.

And according to this post https://keycloak.discourse.group/t/keycloak-postgres-in-docker-compose-what-volumes/17068 you have to include your DB type before building for some reason. So all this changed...

```
FROM quay.io/keycloak/keycloak:25.0.4 as builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Configure a database vendor
ENV KC_DB=postgres

WORKDIR /opt/keycloak
# Add the theme and welcome page setup
COPY ./themes/openrmf/ /opt/keycloak/themes/openrmf/
RUN /opt/keycloak/bin/kc.sh build --spi-x509cert-lookup-provider=nginx

FROM quay.io/keycloak/keycloak:25.0.4
COPY --from=builder /opt/keycloak/ /opt/keycloak/

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
```

## Build the container

```
docker build --no-cache -t cingulara/keycloak-openrmf:25.0.4 .
```

## OpenRMF<sup>&reg;</sup> Theme
https://www.keycloak.org/docs/latest/server_development/#_themes has information on building themes. You run it like below and mount the ./openrmf/ theme into /opt/keycloak/themes/openrmf/ like the `Dockerfile` has for building and copying the theme inside the image you build.

```
start --spi-theme-static-max-age=-1 --spi-theme-cache-themes=false --spi-theme-cache-templates=false
```