---
layout: default
title: Run Latest Development
nav_order: 1100
---

# Running the Latest Development OpenRMF

To run the latest development version of OpenRMF, you can connect to the openrmf-docs GitHub repo as below. Open a command prompt / terminal window and enter that command below:

```
git clone https://github.com/Cingulara/openrmf-docs.git
```

Next, in the terminal window run `git checkout develop` so you are in the right branch. 

If you want to run the latest *production* version of OpenRMF, make sure you run `git checkout master` before you startup OpenRMF.

## Run OpenRMF Latest Production

While in the master branch, go to the scripts/ directory. While in that directory run `./start.sh` or `./start.cmd` for your OS and let it spin up the containers for the database and website. You should see a message on how to go to port 8080 to run the application at the end. You have to have Keycloak running before this. And your `.env` file in that scripts directory has to be edited for the OpenRMF APIs to point to Keycloak for authentication at the API level.

> Remember, use the IP address of your local machine to go to it. It should redirect you to go to Keycloak and login or create a user. Once your user is setup and you can log in, you should see OpenRMF correctly! The Redirect URIs cannot be "localhost" if you are running these components inside Docker. Localhost is local to the docker container!

## Run OpenRMF Latest Development / Edge

While in the develop branch, go to the scripts/edge directory. While in that directory run `./dev-start.sh` or `./dev-start.cmd` for your OS and let it spin up the containers for the database and website. You should see a message on how to go to port 8080 to run the application at the end. And your `.env` file in that scripts directory has to be edited for the OpenRMF APIs to point to Keycloak for authentication at the API level.

> Remember, use the IP address of your local machine to go to it. It should redirect you to go to Keycloak and login or create a user. Once your user is setup and you can log in, you should see OpenRMF correctly! The Redirect URIs cannot be "localhost" if you are running these components inside Docker. Localhost is local to the docker container!
