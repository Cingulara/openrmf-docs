# Run the Keycloak Stack

docker-compose up -d

# tell them the URL for Keycloak
echo ''
echo 'Use http://{ip-address}:9001/ to access Keycloak locally.'
echo ''
echo 'Run a setup (Linux, Mac) script to automate the OpenRMF realm creation'
echo 'if not already done. Please wait 2 to 3 minutes on initial startup before you'
echo 'run that setup script. Keycloak takes a few minutes to initialize.'
echo ''