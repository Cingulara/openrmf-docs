# Get OpenRMF<sup>&reg;</sup> OSS v1.9 or higher Running

> Note that for Docker Desktop users, you need to have the File Sharing turned on to run OpenRMF<sup>&reg;</sup> OSS the way it is designed in the docker-compose file. We use persistent volumes for MongoDB, Grafana, and Prometheus. Also for anyone running on a system with any firewall (Windows Firewall, firewalld, iptables) you will need to have ports 8080 accessible from external if you are not doing everything locally on the same box. If you plan to access the web interface from another connected machine, please ensure your firewall settings allow these ports coming in first.

> Tested with Docker Desktop 2.x onward with 6 CPUs, 8 GB RAM, 1 GB swap and 60 GB Disk Image. You will want more than the default 2 CPU and 2 GB RAM to maximize the use of OpenRMF<sup>&reg;</sup> OSS specifically. Your machine age and hardware will make this vary some. If you see timeouts on Keycloak and OpenRMF<sup>&reg;</sup> OSS when uploading, running reports, or web UI screens taking a long time to load you may want to check the Docker Desktop Resources of your machine.

## Step 1 - Setup your .env file
To run OpenRMF<sup>&reg;</sup> OSS you need to edit your `.env` file and replace the `xxx.xxx.xxx.xxx` with your IP address or DNS name of your host machine. Then save and exit. 

![Step 1 - setup your ENV](./img/install/step1-env.png?raw=true)

## Step 2 - Setup your .grafana file
To run OpenRMF<sup>&reg;</sup> OSS you need to edit your `.grafana` file and replace the `xxx.xxx.xxx.xxx` with your IP address or DNS name of your host machine. Then save and exit. 

![Step 2 - setup your Grafana ENV](./img/install/step2-grafana.png?raw=true)
