# Steps to Secure OpenRMF OSS

Once you set setup there are a few things you can do to further secure OpenRMF OSS configuration. They are listed briefly below.

As always, please make a good backup of your configuration BEFORE doing any of this.

* update the Keycloak `admin` password
* once updated, remove the two lines from the `docker-compose.yml` file for the Keycloak Admin user `KEYCLOAK_ADMIN` and password `KEYCLOAK_ADMIN_PASSWORD`
* update the MongoDB Root passwords
* save the password somewhere safe
* remove the root password lines from the `docker-compose.yml` file for `MONGO_INITDB_ROOT_USERNAME` and `MONGO_INITDB_ROOT_PASSWORD`
* change the grafana `admin` password
* remove the `GF_SECURITY_ADMIN_PASSWORD` from the .grafana file as it should now be persisted
* change the default Postgres password and reference it in the YML correctly when done