---
layout: default
title: Upgrades and Cleanup
nav_order: 2000
---

# Upgrading from older OpenRMF<sup>&reg;</sup> OSS versions
As you upgrade from version 1.0, to 1.2, to 1.6 and then 1.8 and beyond, you will have older container images for the application you no longer need. Most of the time, these are saved in the /var file structure on Linux. There is an open source tool called Portainer that is great for cleanup of older containers. If you have never used this or have had OpenRMF<sup>&reg;</sup> OSS since its inception, you will want to perform this to clean up the older non-used images. On Linux, the /var folder eventually may fill up with these old images.  So it is good to prune older ones that are not needed.

Before you do any of these steps please take a full backup or snapshot of your server, virtual machine or workstation that is running OpenRMF<sup>&reg;</sup> OSS as a precaution. 

# Portainer Registry Screen

To run it perform the following command. You may need “sudo” in front of it depending on your login and permissions. This will load the Portainer interface on port 9005. You can change that to whatever port you wish that is accessible to you and is not already running. 

```
docker run -p 9005:9000 --rm --name=portainer -v /var/run/docker.sock:/var/run/docker.sock -v ~/container_data/portainer:/data portainer/portainer-ce:2.9.0-alpine
```

Then open a browser window to that hostname / IP address using http://xxxxxxxxxxx:9005/ or whatever port you used. On first login you will need to create an administrator account and password to connect to your local Docker registry. Once done click the Local instance and you will see a menu like below. There are a few things to review for cleaning up. It will be best if you are running OpenRMF<sup>&reg;</sup> OSS fully when doing this so you do not remove any running container. If you accidentally remove one, you can always log into SoteriaSoft.Jfrog.io and pull the image again. 

Once the admin login is set up, click on the Get Started button and then on the “local” listing to connect to the local registry. 

## Portainer Volumes Listing
On the next screen click on the Volumes menu on the left and see the volumes on your computer. As long as you are fully running OpenRMF<sup>&reg;</sup> OSS, all the ones marked “Unused” are the ones you can remove. The rest are in use or are needed. You can change the list per page from “10” in the table listing to 50 or 100 depending on how long your listing is. 
To remove older unused volumes, click the checkbox next to the volumes and then click the Remove button above the listing. An example is shown below. Be careful NOT TO remove any specifically named “openrmf” volumes as that is more than likely your real data. 

## Portainer Images Listing
Next, click on the Images menu on the left. Depending on when you began using OpenRMF<sup>&reg;</sup> OSS there may be a list of older images here that are no longer used that are marked “Unused” as well. You can change the list per page from “10” in the table listing to 50 or 100 depending on how long your listing is. 

To remove these older images, click the checkbox next to the images no longer needed and then click the Remove button above the listing. There can be images such as older Prometheus, Grafana, and Vault images as well as several that look like “openrmf-xxx-xxxxxxx”. There are some images listed here such as the openrmf-api-external, mongo-express, ubuntu:latest and portainer images that you should keep. 

## Portainer Cleanup
When all is done you can log out of Portainer to finish the cleanup process. Additionally, when you are done you can remove the “~/container_data” folder in your home directory to wipe all information on Portainer and clean up after this process as well.  

When you want to run Portainer later to clean this up again, repeat these processes.
If you accidentally remove an image that is needed, the “start” procedures will look for them and pull them down again.