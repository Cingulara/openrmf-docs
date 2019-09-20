REM Run the Keycloak Stack

docker-compose up -d

REM tell them the URL for Keycloak
ECHO ""
ECHO "Run http://{ip-address}:9001/ to access Keycloak locally"
ECHO ""