REM Now run the latest development openRMF stack
COMPOSE_PARALLEL_LIMIT=10 docker-compose up -d

REM tell them the URL
ECHO ""
ECHO "Run http://{ip-address}:8080/ to access OpenRMF"
ECHO ""