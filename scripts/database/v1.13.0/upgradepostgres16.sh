echo ''
echo 'Postgres 11 data copy to Postgres 16 starting...'
echo ''

docker exec openrmf-postgres pg_dumpall -U openrmf-keycloak | docker exec -i openrmf-postgres16 psql -U openrmf-keycloak

echo ''
echo 'Postgres 11 data copy to Postgres 16 completed.'
echo ''