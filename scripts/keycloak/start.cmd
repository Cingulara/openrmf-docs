@echo off
REM Run the Keycloak Stack

docker-compose up -d

REM tell them the URL for Keycloak
echo(
ECHO Use http://{ip-address}:9001/ to access Keycloak locally.
ECHO.
ECHO Run the setup-realm-windows.cmd script to automate the OpenRMF realm creation
ECHO if not already done. Please wait 2 to 3 minutes on initial startup before you
ECHO run that setup script. Keycloak takes a few minutes to initialize.
echo(
