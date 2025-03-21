# Upgrade Postgres from 11.2 to 16.2 in OpenRMF<sup>&reg;</sup> OSS

For OpenRMF<sup>&reg;</sup> OSS version 1.12.x and earlier the Postgres Database is version 11.x. That version is now in its end of life phase and must be updated. 

See the blog post https://medium.com/@dale-bingham-soteriasoftware/upgrade-postgres-in-a-docker-podman-container-network-b6c8756ad310 here on how this works. 

For OpenRMF® Professional v1.13 onward with new installations, this is already done from the installation. So if this is the case, the rest of this document is not relevant to you. 

The proper way to upgrade Postgres to a newer version in our software stack is to start the newer Postgres 16 running, connect to the container network we already have, copy all data to it, reset the password, then use the new database setting and path in your configuration. 

To do this we must perform the following steps: 
* backup the current database or virtual machine / server:
* stop OpenRMF Professional v1.12 or earlier
* copy over the `docker-compose.yml` from v1.13 or use it to edit your current YML, noting the postgres16 section
* uncomment the `postgres16:` section in the `docker-compose.yml` file
* start the appliation stack
* run the `./database/v1.13.0/upgradepostgres16.sh` file, making sure the user/database/password for the current postgres and your postgres are the same
* connect to Postgres 16 and reset the openrmf-keycloak password 
* stop the main software stack 
* update the Postgres 16 YML configuration in `docker-compose.yml` to only run Postgres 16 and use the proper persistent volume
* restart the software stack with all correct configuration 

The rest of the document outlines this method to copy all data and settings, users, permissions, and other data correctly. Throughout the document, you can replace docker with podman if you are on Red Hat Linux and running Podman.

## Step 1: Download and unzip v1.13 of OpenRMF<sup>&reg;</sup> OSS
Download version 1.13 or later of OpenRMF<sup>&reg;</sup> OSS. Then unzip the contents.

Note the `docker-compose.yml` file in there with the changes on Postgres 16 commented like below. To do this 

## Step 2: Uncomment the lines below in the docker-compose.yml file

Find this area in the `docker-compose.yml` file and uncomment it to make it active. Stop and restart the stack so there are 2 Postgres containers running with different names.

```
  # postgres16:
  #   image: docker.io/postgres:16.2-alpine
  #   container_name: openrmf-postgres16
  #   restart: on-failure:5
  #   ports:
  #     - "5432"
  #   environment:
  #     - POSTGRES_DB=openrmf-keycloak 
  #     - POSTGRES_USER=openrmf-keycloak 
  #     - POSTGRES_PASSWORD=xxxxxxxxxxxxxxxxx
  #   networks:
  #     - openrmf
  #   volumes:
  #     - keycloak-postgres16:/var/lib/postgresql/data
```

Finally, jump down to the `volumes:` area and uncomment the `keycloak-postgres16:` line so we can use it for persitent storage. 

```
volumes:
  template-data-volume:
  checklist-data-volume:
  score-data-volume:
  audit-data-volume:
  report-data-volume:
  openrmf-prometheus-data-volume:
  openrmf-grafana-data-volume:
  keycloak-postgres:
  keycloak-postgres16:
```


## Step 3: Update the Postgres 16.2 instance
With the stack running, run the `./database/v1.13.00/upgradepostgres16.sh` script. You should see some set, create, alter type statements. It should finish within one minute.

Next, to update the Postgres user password, run 

```
docker exec -it openrmf-postgres16 /bin/sh
```

to get into the running container.  Then log in to Postgres inside the running container using 

```
psql -h localhost -p 5432 -U openrmf-keycloak -W
```

Now, enter the current password to get to a Postgres prompt. 

We recommend doing this whether your password is the default password or not. And it ensures the password used in the `docker-compose.yml` file is correct. 

To change the password, use the command 

```
\password openrmf-keycloak
```

and press the Enter key. When prompted, enter the new password correctly and then enter it a second time to confirm it. When done enter these 2 commands to get back to the command prompt use 

```
\q 

exit
```

## Step 4: Stop the stack
Stop the software stack fully.

## Step 5: Edit the docker-compose.yml file
Now edit your `docker-compose.yml` file and comment out the regular postgres: section like below:

```
  # postgres:
  #   container_name: openrmf-postgres
  #   image: docker.io/postgres:11.22-alpine3.19
  #   restart: on-failure:10
  #   ports:
  #     - "5432"
  #   environment:
  #     - POSTGRES_DB=openrmf-keycloak 
  #     - POSTGRES_USER=openrmf-keycloak 
  #     - POSTGRES_PASSWORD=xxxxxxxxxxxxxxxxx
  #   networks:
  #     - openrmf
  #   volumes:
  #     - keycloak-postgres:/var/lib/postgresql/data
```

Also jump down to the `keycloak:` area and make sure the `KC_DB_URL` environment area for Keycloak points to `openrmf-postgres16` versus `openrmf-postgres` in the database connection URL. And the `depends_on:` also points to `postgres16`.

```
  keycloak: 
    container_name: openrmf-keycloak
    image: docker.io/cingulara/keycloak-openrmf:26.1.0
    restart: on-failure:10
    command:
      - start
      - --spi-theme-welcome-theme=openrmf
    ports:
      - "8080"
    environment:
      - KC_DB=postgres
      - KC_DB_URL=jdbc:postgresql://openrmf-postgres16:5432/openrmf-keycloak
      - KC_DB_USERNAME=openrmf-keycloak
      - KC_DB_PASSWORD=xxxxxxxxxxxxxxxxx
      - KEYCLOAK_ADMIN=admin
      - KEYCLOAK_ADMIN_PASSWORD=admin
      - KC_HOSTNAME_STRICT=false
      - KC_PROXY_HEADERS=xforwarded
      - KC_HTTP_RELATIVE_PATH=/auth
      - KC_HTTP_ENABLED=true
      - KC_HTTP_PORT=8080
      - KC_HEALTH_ENABLED=true
      - KC_METRICS_ENABLED=true
      # - KC_LOG_LEVEL=DEBUG
    depends_on:
      - postgres16
    networks:
      - openrmf
```

Finally, jump down to the `volumes:` area and comment out the `keycloak-postgres:` line as we do not need it any more.

```
volumes:
  template-data-volume:
  checklist-data-volume:
  score-data-volume:
  audit-data-volume:
  report-data-volume:
  openrmf-prometheus-data-volume:
  openrmf-grafana-data-volume:
  # keycloak-postgres:
  keycloak-postgres16:
```

## Step 6: Restart the stack and check that your Keycloak is working

Once the stack is up check that your `/auth/` is still working correctly. If not run `docker logs openrmf-keycloak` to see what errors you get and troubleshoot from there.