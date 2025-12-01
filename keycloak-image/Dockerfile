FROM quay.io/keycloak/keycloak:26.4.4 AS builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# OpenRMF Professional configuration items
ENV KC_HTTP_ENABLED=true
ENV KC_HTTP_PORT=8080
ENV KC_HOSTNAME_STRICT=false
ENV PROXY_ADDRESS_FORWARDING=true
ENV KC_HTTP_RELATIVE_PATH=/auth

# Configure a database vendor
ENV KC_DB=postgres

WORKDIR /opt/keycloak
# Add the theme and welcome page setup
COPY ./themes/openrmf/ /opt/keycloak/themes/openrmf/
RUN /opt/keycloak/bin/kc.sh build --spi-x509cert-lookup-provider=nginx

FROM quay.io/keycloak/keycloak:26.4.4
COPY --from=builder /opt/keycloak/ /opt/keycloak/

ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]