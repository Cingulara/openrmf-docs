#!/bin/bash

type jq > /dev/null
if [ $? != 0 ]; then
  echo "Please install jq from https://stedolan.github.io/jq/."
  echo "  jq is needed to parse JSON."
  exit
fi

#
# I find a mixture of sudo and non-sudo, to be a source of bugs. So I've
# added a sudo check and removed sudo from the command below this point.
#

NC="\e[0m"
RED="\e[0;31m"
CYAN="\e[0;36m"
BOLD=$(tput bold)
NORMAL=$(tput sgr0)

if [ "$EUID" -ne 0 ]; then
  echo -e "${BOLD}${RED}You are not running this script as root.${NC}${NORMAL}"
  echo -e "$CYAN"
  echo "  This script uses docker which frequently requires sudo to run."
  echo "  Therefore, please either edit this script to remove this check"
  echo "  or run the script using sudo."
  echo -e "$NC"
  exit
fi

echo
echo -e "${BOLD}Keycloak Server IP${NORMAL}"
echo -e "$CYAN"
echo "  The Keycloak container is running in a docker container. It is"
echo "  probably called 'keycloak_keycloak_1' or something similiar."
echo
echo "  In 'docker ps' it shows as listening on port 9001."
echo -e "$NC"
read -p "  What is it's IP address? " keyip #>> $pathtohome/openrmf-Install.log

echo
echo -e "${BOLD}OpenRMF Administrator account${NORMAL}"
echo -e "$CYAN"
echo "  Note that Keycloak has its own administrator account called 'admin'."
echo "  Consider using 'rmf-admin' or anything but 'admin' itself."
echo -e "$NC"
read -p "  Enter the Name of the first OpenRMF Administrator account: " openuser

#
# NOTE: It is expected that only one keyclock container is running.
#

##BEGIN Locate Keycloak Container ID
echo
echo "Discovering local Keycloak Docker Container..."
keycontainer="$(docker ps | grep "jboss/keycloak:" | awk '{ print $1 }')"
echo "keycontainer: $keycontainer"
##END Locate Keycloak Container ID

##BEGIN Authenticate to Keycloak server
echo
echo "Authenticating to Keycloak Master Realm..."
docker exec $keycontainer /opt/jboss/keycloak/bin/kcadm.sh config credentials --server http://$keyip:8080/auth --realm master --user admin --password admin
##END Authenticate to Keycloak server

##BEGIN Create Realm
echo
echo "Creating the Realm..."
docker exec -i $keycontainer /opt/jboss/keycloak/bin/kcadm.sh create realms -s realm=openrmf -s enabled=true
##END Create Realm

##BEGIN Disable SSL Requirement
echo
echo "Setting Require SSL to none (off)..."
docker exec -i $keycontainer /opt/jboss/keycloak/bin/kcadm.sh update realms/openrmf --set 'sslRequired=none'
##END Disable SSL Requirement

##BEGIN Create Password Policy
echo
echo "Creating the Password Policy (12 digits, 2 upper, 2 lower, 2 number, 2 special character)..."
docker exec $keycontainer /opt/jboss/keycloak/bin/kcadm.sh update realms/openrmf -s 'passwordPolicy="hashIterations and specialChars and upperCase and digits and notUsername and length"'
##END Create Password Policy

##BEGIN Create Roles
echo
echo "Creating the 5 OpenRMF Roles..."
docker exec $keycontainer /opt/jboss/keycloak/bin/kcadm.sh create roles -r openrmf -s name=Administrator -s 'description=Admin role for openrmf'
docker exec $keycontainer /opt/jboss/keycloak/bin/kcadm.sh create roles -r openrmf -s name=Assessor -s 'description=Assessor Role for openrmf'
docker exec $keycontainer /opt/jboss/keycloak/bin/kcadm.sh create roles -r openrmf -s name=Download -s 'description=Download Role to pull down XLSX and CKL files in openrmf'
docker exec $keycontainer /opt/jboss/keycloak/bin/kcadm.sh create roles -r openrmf -s name=Editor -s 'description=Editor role for openrmf'
docker exec $keycontainer /opt/jboss/keycloak/bin/kcadm.sh create roles -r openrmf -s name=Reader -s 'description=Read-Only role for openrmf'
##END Create Roles

##BEGIN Create Client
echo
echo "Creating client"
cid=$(docker exec -i $keycontainer /opt/jboss/keycloak/bin/kcadm.sh get clients -r openrmf -q clientId=openrmf 2>/dev/null | jq --raw-output '.[0].id')
if [ -z $cid ]; then
  cid=$(docker exec -i $keycontainer /opt/jboss/keycloak/bin/kcadm.sh create clients -r openrmf -s enabled=true -s clientId=openrmf -s publicClient=true -s 'description=openrmf login for Web and APIs' -s 'redirectUris=["http://'$keyip':8080/*"]' -s 'webOrigins=["*"]' -i)
fi
echo "Client ID: $cid"
##END Create Client

##BEGIN Create Protocol Mapper
echo
echo "Creating the Client Protocol Mapper..."
docker exec -i $keycontainer /opt/jboss/keycloak/bin/kcadm.sh create \
  clients/$cid/protocol-mappers/models \
    -r openrmf \
    -s name=roles \
    -s protocol=openid-connect \
    -s protocolMapper=oidc-usermodel-realm-role-mapper \
    -s 'config."id.token.claim"=true' \
    -s 'config."claim.name"=roles' \
    -s 'config."jsonType.label"=String' \
    -s 'config."multivalued"=true' \
    -s 'config."userinfo.token.claim"=true' \
    -s 'config."access.token.claim"=true'
##END Create Protocol Mapper

##BEGIN Create first admin
echo
echo "Creating the first OpenRMF Administrator account...you will have to set a password in the Keycloak UI"
docker exec -i $keycontainer /opt/jboss/keycloak/bin/kcadm.sh create users -r openrmf -s username=$openuser -s enabled=true -s 'requiredActions=["UPDATE_PASSWORD"]'
docker exec -i $keycontainer /opt/jboss/keycloak/bin/kcadm.sh add-roles --uusername $openuser --rolename Administrator -r openrmf
docker exec -i $keycontainer /opt/jboss/keycloak/bin/kcadm.sh add-roles --uusername $openuser --rolename Assessor -r openrmf
docker exec -i $keycontainer /opt/jboss/keycloak/bin/kcadm.sh add-roles --uusername $openuser --rolename Download -r openrmf
docker exec -i $keycontainer /opt/jboss/keycloak/bin/kcadm.sh add-roles --uusername $openuser --rolename Editor -r openrmf
docker exec -i $keycontainer /opt/jboss/keycloak/bin/kcadm.sh add-roles --uusername $openuser --rolename Reader -r openrmf
##END Create first openrmf admin

##BEGIN Password Policy of 2/2/2/2 12 characters and not the same as the username
echo
echo "Setting the password policy to 12 characters, 2 upper, 2 lower, 2 number, 2 special char"
docker exec -i $keycontainer /opt/jboss/keycloak/bin/kcadm.sh update realms/openrmf -s 'passwordPolicy="hashIterations(27500) and specialChars(2) and upperCase(2) and digits(2) and notUsername(undefined) and length(12)"'
##END Password Policy

##BEGIN Add Reader Role to Default Realm Roles
echo
echo "Last step - Adding Reader Role to Default Realm Roles..."
docker exec -i $keycontainer /opt/jboss/keycloak/bin/kcadm.sh update realms/openrmf -f - <<EOF
{"defaultRoles" :["offline_access", "uma_authorization", "Reader"]}
EOF
##END Add Reader Role to Default Realm Roles
