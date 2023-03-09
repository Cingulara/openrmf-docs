# Now run the latest development openRMF stack
COMPOSE_PARALLEL_LIMIT=30 docker compose up -d

# tell them the URL
echo ''
echo 'Run http://{ip-address}:8080/ to access OpenRMF'
echo ''
