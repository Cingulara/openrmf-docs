# Build your own Keycloak Optimized Container Image

https://www.keycloak.org/server/containers

We of course need to add in our theme and such.

And according to this post https://keycloak.discourse.group/t/keycloak-postgres-in-docker-compose-what-volumes/17068 you have to include your DB type before building for some reason. So all this changed...

```
FROM quay.io/keycloak/keycloak:20.0.3 as builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Configure a database vendor
ENV KC_DB=postgres

WORKDIR /opt/keycloak
RUN /opt/keycloak/bin/kc.sh build

FROM quay.io/keycloak/keycloak:20.0.3
COPY --from=builder /opt/keycloak/ /opt/keycloak/

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
```

## Build the container

```
docker build --no-cache -t cingulara/keycloak-openrmf:20.0.3 .
```