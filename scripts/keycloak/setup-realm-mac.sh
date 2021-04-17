echo
echo "Please make sure your Keycloak containers have been up for at least 2 - 3 minutes as the initial setup and loading are time consuming. Otherwise this script will fail."
echo
echo "You should be able to go to http:{ip-address}:9001/auth/ and see the starting screen before running this."
echo
echo "Enter the IP of the local Keycloak server (runs on port 9001):"
read keyip #>> $pathtohome/openrmf-Install.log

echo
echo "Enter the Name of the first OpenRMF Administrator account:"
read openuser

##BEGIN Locate Keycloak Container ID
echo
echo "Discovering local Keycloak Docker Container"
keycontainer="$(docker ps | grep "jboss/keycloak:" | awk '{ print $1 }')"
echo "$keycontainer"
##END Locate Keycloak Container ID

##BEGIN Authenticate to Keycloak server
echo
echo "Authenticating to Keycloak Master Realm..."
docker exec $keycontainer /opt/jboss/keycloak/bin/kcadm.sh config credentials --server http://$keyip:9001/auth --realm master --user admin --password admin
##END Authenticate to Keycloak server

##BEGIN Create Realm
echo
echo "Creating the Realm..."
docker exec -i $keycontainer /opt/jboss/keycloak/bin/kcadm.sh create realms -s realm=openrmf -s enabled=true
##END Create Realm

##BEGIN Disable SSL Requirement
echo
echo "Setting OpenRMF Realm Options (SSL off, Display Name)..."
docker exec -i $keycontainer /opt/jboss/keycloak/bin/kcadm.sh update realms/openrmf --set 'sslRequired=none'
docker exec -i $keycontainer /opt/jboss/keycloak/bin/kcadm.sh update realms/openrmf --set 'displayName=OpenRMF OSS'
docker exec -i $keycontainer /opt/jboss/keycloak/bin/kcadm.sh update realms/openrmf --set 'displayNameHtml=OpenRMF OSS'
##END Disable SSL Requirement

##BEGIN Create Password Policy
echo
echo "Setting the Initial Password Policy..."
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
echo "Creating the Keycloak Client..."
cid=$(docker exec -i $keycontainer /opt/jboss/keycloak/bin/kcadm.sh create clients -r openrmf -s enabled=true -s clientId=openrmf -s publicClient=true -s 'description=openrmf login for Web and APIs' -s 'redirectUris=["http://'$keyip':8080/*"]' -s 'webOrigins=["*"]' -i)
echo "$cid"
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
echo "Last Step - Adding Reader Role to Default Realm Roles..."
docker exec -i $keycontainer /opt/jboss/keycloak/bin/kcadm.sh update realms/openrmf -f - <<EOF
{"defaultRoles" :["offline_access", "uma_authorization", "Reader"]}
EOF
echo
echo "Completed!"
##END Add Reader Role to Default Realm Roles  
