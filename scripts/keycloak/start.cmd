REM Run the Keycloak Stack

docker-compose up -d

REM tell them the URL for Keycloak
ECHO ""
ECHO "Use http://{ip-address}:9001/ to access Keycloak locally."
ECHO "Run a setup (Linux, Mac, Windows) script to automate the OpenRMF realm creation."
ECHO ""