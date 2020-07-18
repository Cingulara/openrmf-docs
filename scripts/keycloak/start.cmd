@echo off
REM Run the Keycloak Stack

docker-compose up -d

REM tell them the URL for Keycloak
echo(
ECHO "Use http://{ip-address}:9001/ to access Keycloak locally."
ECHO "Run the setup-realm-windows.cmd script to automate the OpenRMF realm creation."
echo(
