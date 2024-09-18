@echo off
echo(
ECHO Please make sure your Keycloak containers have been up for at least 2 - 3 minutes as the initial setup and loading are time consuming. Otherwise this script will fail.
ECHO.
ECHO You should be able to go to http:{ip-address}:8080/auth/ and see the starting screen before running this.
ECHO.
set /p keyip=Enter the IP of the local Keycloak server (runs on port 8080): 

echo(
set /p openuser=Enter the Name of the first OpenRMF Administrator account: 

ECHO.
REM BEGIN Locate Keycloak Container ID
ECHO Discovering local Keycloak Docker Container
FOR /F %%g IN ('docker ps -aqf "name=keycloak"') DO set keycontainer=%%g
ECHO Container: %keycontainer%
REM END Locate Keycloak Container ID

REM BEGIN Authenticate to Keycloak server
echo(
ECHO Authenticating to Keycloak Master Realm...
docker exec %keycontainer% /opt/keycloak/bin/kcadm.sh config credentials --server http://%keyip%:8080/auth --realm master --user admin --password admin
REM END Authenticate to Keycloak server

REM BEGIN Create Realm
echo(
ECHO Creating the Realm...
docker exec -i %keycontainer% /opt/keycloak/bin/kcadm.sh create realms -s realm=openrmf -s enabled=true
REM END Create Realm

REM BEGIN Disable SSL Requirement
echo(
ECHO Setting Require SSL to none (off)...
docker exec -i %keycontainer% /opt/keycloak/bin/kcadm.sh update realms/openrmf --set "sslRequired=none"
docker exec -i %keycontainer% /opt/keycloak/bin/kcadm.sh update realms/master --set "sslRequired=none"
docker exec -i %keycontainer% /opt/keycloak/bin/kcadm.sh update realms/openrmf --set "displayName=OpenRMF OSS"
docker exec -i %keycontainer% /opt/keycloak/bin/kcadm.sh update realms/openrmf --set "displayNameHtml=OpenRMF OSS"
docker exec -i %keycontainer% /opt/keycloak/bin/kcadm.sh update realms/openrmf --set "displayName=OpenRMF OSS"
docker exec -i %keycontainer% /opt/keycloak/bin/kcadm.sh update realms/openrmf --set "displayNameHtml=OpenRMF<sup>&reg;</sup> OSS"
docker exec -i %keycontainer% /opt/keycloak/bin/kcadm.sh update realms/openrmf --set "loginTheme=openrmf"
docker exec -i %keycontainer% /opt/keycloak/bin/kcadm.sh update realms/openrmf --set "accountTheme=keycloak.v3"
docker exec -i %keycontainer% /opt/keycloak/bin/kcadm.sh update realms/master --set "accountTheme=keycloak.v3"
docker exec -i %keycontainer% /opt/keycloak/bin/kcadm.sh update realms/master --set "adminTheme=keycloak.v2"
docker exec -i %keycontainer% /opt/keycloak/bin/kcadm.sh update realms/openrmf --set "adminTheme=keycloak.v2"
docker exec -i %keycontainer% /opt/keycloak/bin/kcadm.sh update realms/master --set "loginTheme=openrmf"
docker exec -i %keycontainer% /opt/keycloak/bin/kcadm.sh update realms/master --set "displayNameHtml=OpenRMF<sup>&reg;</sup> OSS User Administration"
REM END Disable SSL Requirement

REM BEGIN Create Roles
echo(
ECHO Creating the 5 OpenRMF Roles...
docker exec -i %keycontainer% /opt/keycloak/bin/kcadm.sh create roles -r openrmf -s name=Administrator -s "description=Admin role for openrmf"
docker exec -i %keycontainer% /opt/keycloak/bin/kcadm.sh create roles -r openrmf -s name=Assessor -s "description=Assessor Role for openrmf"
docker exec -i %keycontainer% /opt/keycloak/bin/kcadm.sh create roles -r openrmf -s name=Download -s "description=Download Role to pull down XLSX and CKL files in openrmf"
docker exec -i %keycontainer% /opt/keycloak/bin/kcadm.sh create roles -r openrmf -s name=Editor -s "description=Editor role for openrmf"
docker exec -i %keycontainer% /opt/keycloak/bin/kcadm.sh create roles -r openrmf -s name=Reader -s "description=Read-Only role for openrmf"
REM END Create Roles

REM BEGIN Create Client 
echo(
ECHO Creating the Keycloak Client...
FOR /F %%c IN ('docker exec -i %keycontainer% /opt/keycloak/bin/kcadm.sh create clients -r openrmf -s "enabled=true" -s "clientId=openrmf" -s "publicClient=true" -s "description=OpenRMF login for Web and APIs" -s "redirectUris=[\"http://%keyip%:8080/*\"]" -s "webOrigins=[\"*\"]" -i ') DO set cid=%%c
REM ECHO "%cid%"
REM END Create Client

REM BEGIN Create Protocol Mapper
echo(
ECHO Creating the Client Protocol Mapper...
docker exec -i %keycontainer% /opt/keycloak/bin/kcadm.sh create clients/%cid%/protocol-mappers/models -r openrmf -f - < rolemapper.json 
REM END Create Protocol Mapper

REM BEGIN Create first admin
echo(
ECHO Creating the first OpenRMF Administrator account...you will have to set a password in the Keycloak UI
docker exec -i %keycontainer% /opt/keycloak/bin/kcadm.sh create users -r openrmf -s username=%openuser% -s enabled=true
docker exec -i %keycontainer% /opt/keycloak/bin/kcadm.sh add-roles --uusername %openuser% --rolename Administrator -r openrmf
docker exec -i %keycontainer% /opt/keycloak/bin/kcadm.sh add-roles --uusername %openuser% --rolename Assessor -r openrmf
docker exec -i %keycontainer% /opt/keycloak/bin/kcadm.sh add-roles --uusername %openuser% --rolename Download -r openrmf
docker exec -i %keycontainer% /opt/keycloak/bin/kcadm.sh add-roles --uusername %openuser% --rolename Editor -r openrmf
docker exec -i %keycontainer% /opt/keycloak/bin/kcadm.sh add-roles --uusername %openuser% --rolename Reader -r openrmf
REM END Create first openrmf admin

REM BEGIN Password Policy of 2/2/2/2 12 characters and not the same as the username
echo(
ECHO Setting the password policy to 12 characters, 2 upper, 2 lower, 2 number, 2 special char
docker exec -i %keycontainer% /opt/keycloak/bin/kcadm.sh update realms/openrmf -s "passwordPolicy='hashIterations(27500) and specialChars(2) and upperCase(2) and digits(2) and notUsername(undefined) and length(12)'"
REM END Password Policy

REM BEGIN Add Reader Role to Default Realm Roles
echo(
ECHO Last Step - Adding Reader Role to Default Realm Roles...
docker exec -i %keycontainer% /opt/keycloak/bin/kcadm.sh update realms/openrmf -f - < defaultroles.json
echo(
ECHO Congratulations! The OpenRMF OSS Keycloak realm has been created successfully!
REM END Add Reader Role to Default Realm Roles  