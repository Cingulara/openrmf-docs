#!/bin/bash

##BEGIN Authenticate to Keycloak server
echo
echo "Authenticating to Keycloak Master Realm..."
kubectl exec -n $1 $2 -- /opt/jboss/keycloak/bin/kcadm.sh config credentials --server http://localhost:8080/auth --realm master --user admin --password myl0ngPassw0rd
##END Authenticate to Keycloak server

##BEGIN Create Realm
echo
echo "Creating the Realm..."
kubectl exec -n $1 $2 -- /opt/jboss/keycloak/bin/kcadm.sh create realms -s realm=openrmf -s enabled=true
##END Create Realm

##BEGIN Disable SSL Requirement
echo
echo "Setting Require SSL to none (off)..."
kubectl exec -n $1 $2 -- /opt/jboss/keycloak/bin/kcadm.sh update realms/openrmf --set 'sslRequired=none'
kubectl exec -n $1 $2 -- /opt/jboss/keycloak/bin/kcadm.sh update realms/openrmf --set 'displayName=OpenRMF OSS'
kubectl exec -n $1 $2 -- /opt/jboss/keycloak/bin/kcadm.sh update realms/openrmf --set 'displayNameHtml=OpenRMF OSS'
kubectl exec -n $1 $2 -- /opt/jboss/keycloak/bin/kcadm.sh update realms/openrmf --set 'loginTheme=openrmf'
kubectl exec -n $1 $2 -- /opt/jboss/keycloak/bin/kcadm.sh update realms/openrmf --set 'accountTheme=openrmf'
kubectl exec -n $1 $2 -- /opt/jboss/keycloak/bin/kcadm.sh update realms/master --set 'accountTheme=openrmf'
kubectl exec -n $1 $2 -- /opt/jboss/keycloak/bin/kcadm.sh update realms/openrmf --set 'adminTheme=openrmf'
##END Disable SSL Requirement

##BEGIN Create Password Policy
echo
echo "Creating the initial Password Policy ..."
kubectl exec -n $1 $2 -- /opt/jboss/keycloak/bin/kcadm.sh update realms/openrmf -s 'passwordPolicy="hashIterations and specialChars and upperCase and digits and notUsername and length"'
##END Create Password Policy

##BEGIN Create Roles
echo
echo "Creating the 5 OpenRMF Roles..."
kubectl exec -n $1 $2 -- /opt/jboss/keycloak/bin/kcadm.sh create roles -r openrmf -s name=Administrator -s 'description=Admin role for openrmf'
kubectl exec -n $1 $2 -- /opt/jboss/keycloak/bin/kcadm.sh create roles -r openrmf -s name=Assessor -s 'description=Assessor Role for openrmf'
kubectl exec -n $1 $2 -- /opt/jboss/keycloak/bin/kcadm.sh create roles -r openrmf -s name=Download -s 'description=Download Role to pull down XLSX and CKL files in openrmf'
kubectl exec -n $1 $2 -- /opt/jboss/keycloak/bin/kcadm.sh create roles -r openrmf -s name=Editor -s 'description=Editor role for openrmf'
kubectl exec -n $1 $2 -- /opt/jboss/keycloak/bin/kcadm.sh create roles -r openrmf -s name=Reader -s 'description=Read-Only role for openrmf'
##END Create Roles

##BEGIN Create Client
echo
echo "Creating client"
cid=$(kubectl exec -n $1 $2 -- /opt/jboss/keycloak/bin/kcadm.sh create clients -r openrmf -s enabled=true -s clientId=openrmf -s publicClient=true -s 'description=openrmf login for Web and APIs' -s 'redirectUris=["http://'$3'/*"]' -s 'webOrigins=["*"]' -i)
echo "Client ID: $cid"
##END Create Client

##BEGIN Create Protocol Mapper
echo
echo "Creating the Client Protocol Mapper..."
kubectl exec -n $1 $2 -- /opt/jboss/keycloak/bin/kcadm.sh create \
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
kubectl exec -n $1 $2 -- /opt/jboss/keycloak/bin/kcadm.sh create users -r openrmf -s username=$4 -s enabled=true -s 'requiredActions=["UPDATE_PASSWORD"]'
kubectl exec -n $1 $2 -- /opt/jboss/keycloak/bin/kcadm.sh add-roles --uusername $4 --rolename Administrator -r openrmf
kubectl exec -n $1 $2 -- /opt/jboss/keycloak/bin/kcadm.sh add-roles --uusername $4 --rolename Assessor -r openrmf
kubectl exec -n $1 $2 -- /opt/jboss/keycloak/bin/kcadm.sh add-roles --uusername $4 --rolename Download -r openrmf
kubectl exec -n $1 $2 -- /opt/jboss/keycloak/bin/kcadm.sh add-roles --uusername $4 --rolename Editor -r openrmf
kubectl exec -n $1 $2 -- /opt/jboss/keycloak/bin/kcadm.sh add-roles --uusername $4 --rolename Reader -r openrmf
##END Create first openrmf admin

##BEGIN Password Policy of 2/2/2/2 12 characters and not the same as the username
echo
echo "Setting the password policy to 12 characters, 2 upper, 2 lower, 2 number, 2 special char"
kubectl exec -n $1 $2 -- /opt/jboss/keycloak/bin/kcadm.sh update realms/openrmf -s 'passwordPolicy="hashIterations(27500) and specialChars(2) and upperCase(2) and digits(2) and notUsername(undefined) and length(12)"'
##END Password Policy

##BEGIN Add Reader Role to Default Realm Roles
echo
echo "Last step - Adding Reader Role to Default Realm Roles..."
kubectl exec -n $1 $2 -- /opt/jboss/keycloak/bin/kcadm.sh update realms/openrmf -f - <<EOF
{"defaultRoles" :["offline_access", "uma_authorization", "Reader"]}
EOF
##END Add Reader Role to Default Realm Roles
