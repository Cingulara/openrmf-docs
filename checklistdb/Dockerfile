FROM mongo:4.0.5
# copy startup file scripts into /docker-entrypoint-initdb.d
COPY initialize.js /docker-entrypoint-initdb.d/initialize.js
# MONGO_INITDB_DATABASE openrmf