  echo "IP of the Keycloak server (runs on port 9001)"
  read keyip #>> $pathtohome/openrmf-Install.log

  echo "Name of the first OpenRMF admin account"
  read openuser

  ##BEGIN Locate Keycloak Container ID
    echo "Discovering Keycloak Docker Container"
    keycontainer="$(sudo docker ps | grep "jboss/keycloak:" | awk '{ print $1 }')"
    echo "$keycontainer"
  ##END Locate Keycloak Container ID

  ##BEGIN Authenticate to Keycloak server
    echo "Authenticating to Keycloak Master Realm"
    sudo docker exec $keycontainer /opt/jboss/keycloak/bin/kcadm.sh config credentials --server http://$keyip:9001/auth --realm master --user admin --password admin
  ##END Authenticate to Keycloak server

  ##BEGIN Create Realm
    echo "Creating Realm"
    sudo docker exec -i $keycontainer /opt/jboss/keycloak/bin/kcadm.sh create realms -s realm=openrmf -s enabled=true
  ##END Create Realm

  ##BEGIN Create Password Policy
    echo "Creating Password Policy"
    sudo docker exec $keycontainer /opt/jboss/keycloak/bin/kcadm.sh update realms/openrmf -s 'passwordPolicy="hashIterations and specialChars and upperCase and digits and notUsername and length"'
  ##END Create Password Policy 

  ##BEGIN Create Roles
    echo "Creating Realm Roles"
    sudo docker exec $keycontainer /opt/jboss/keycloak/bin/kcadm.sh create roles -r openrmf -s name=Administrator -s 'description=Admin role for openrmf'
    sudo docker exec $keycontainer /opt/jboss/keycloak/bin/kcadm.sh create roles -r openrmf -s name=Assessor -s 'description=Assessor Role for openrmf'
    sudo docker exec $keycontainer /opt/jboss/keycloak/bin/kcadm.sh create roles -r openrmf -s name=Download -s 'description=Download Role to pull down XLSX and CKL files in openrmf'
    sudo docker exec $keycontainer /opt/jboss/keycloak/bin/kcadm.sh create roles -r openrmf -s name=Editor -s 'description=Editor role for openrmf'
    sudo docker exec $keycontainer /opt/jboss/keycloak/bin/kcadm.sh create roles -r openrmf -s name=Reader -s 'description=Read-Only role for openrmf'
  ##END Create Roles

  ##BEGIN Create Client 
    echo "Creating Client"
    cid=$(sudo docker exec -i $keycontainer /opt/jboss/keycloak/bin/kcadm.sh create clients -r openrmf -s enabled=true -s clientId=openrmf -s publicClient=true -s 'description=openrmf login for Web and APIs' -s 'redirectUris=["http://'$keyip':8080/*"]' -s 'webOrigins=["*"]' -i)
    echo "$cid"
  ##END Create Client

  ##BEGIN Create Protocol Mapper
    echo "Creating Client Protocol Mapper" 
    sudo docker exec -i $keycontainer /opt/jboss/keycloak/bin/kcadm.sh create \
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
    echo "Creating first openrmf admin" 
    sudo docker exec -i $keycontainer /opt/jboss/keycloak/bin/kcadm.sh create users -r openrmf -s username=$openuser -s enabled=true -s 'requiredActions=["UPDATE_PASSWORD"]'
    sudo docker exec -i $keycontainer /opt/jboss/keycloak/bin/kcadm.sh add-roles --uusername $openuser --rolename Administrator -r openrmf
    sudo docker exec -i $keycontainer /opt/jboss/keycloak/bin/kcadm.sh add-roles --uusername $openuser --rolename Assessor -r openrmf
    sudo docker exec -i $keycontainer /opt/jboss/keycloak/bin/kcadm.sh add-roles --uusername $openuser --rolename Download -r openrmf
    sudo docker exec -i $keycontainer /opt/jboss/keycloak/bin/kcadm.sh add-roles --uusername $openuser --rolename Editor -r openrmf
    sudo docker exec -i $keycontainer /opt/jboss/keycloak/bin/kcadm.sh add-roles --uusername $openuser --rolename Reader -r openrmf
  ##END Create first openrmf admin

  ##BEGIN Password Policy of 2/2/2/2 12 characters and not the same as the username
    sudo docker exec -i $keycontainer /opt/jboss/keycloak/bin/kcadm.sh update realms/openrmf -s 'passwordPolicy="hashIterations(27500) and specialChars(2) and upperCase(2) and digits(2) and notUsername(undefined) and length(12)"'
  ##END Password Policy

  ##BEGIN Add Reader Role to Default Realm Roles
   echo "Adding Reader Role to Default Realm Roles"
     sudo docker exec -i $keycontainer /opt/jboss/keycloak/bin/kcadm.sh update realms/openrmf -f - << echo {"defaultRoles" :["offline_access", "uma_authorization", "Reader"]} 
  ##END Add Reader Role to Default Realm Roles
