# Get OpenRMF Core Running Locally


## Step 1 - Get Keycloak Running
To run OpenRMF you first need Keycloak running. I have a ZIP file under the [latest release](https://github.com/Cingulara/openrmf-docs/releases) just for the Keycloak setup. Download that and put into its own directory. Then run the `start.sh` or `start.cmd` file to run it. If you do not have Keycloak and Postgres (they work together for this) as containers, this script will also help download them. Then run them. 

Once you have Keyloak setup, if you have a Linux or Mac you can automate the setup. A Windows setup script is coming. For Windows users, check the [Keycloak manual steps](keycloak.md) file and then come back here. Everyone else, run that script locally and enter the IP of your machine (it looks locally for the Keycloak container) and then enter a starting user. The rest is done for you. The results should look like the below. 

![Keycloak Setup Script](./img/keycloak/setup-script.png?raw=true)

Now, you can launch the http://localhost:9001/auth URL in a browser. Click on the "Administrator Console" block on the bottom left and you are presented with a login prompt. Use the admin/admin login from the keycloak docker-compose file (or whatever you changed it to) to get into the Keycloak UI. Click the "View all users" button and then click on your user you just made (see below).

![Keycloak User Setup](./img/keycloak/keycloak-setup-users.png?raw=true)

Optional: click the "x" next to "Update Password" and Save this first tab if you wish.

Now you can click the Credentials tab, and then ente a new password that is 12 characters and follows the 2/2/2/2 rule. 2 upper, 2 lower, 2 special character and 2 numbers in the password. Click the "Temporary" if you want to turn that off. Then click "Reset Password" and verify.

![Keycloak User Setup](./img/keycloak/user-credentials.png?raw=true)

Keycloak is setup! On to Step 2.

> You also possibly use another OpenID compliant application to provide AuthN and AuthZ. I have not tested any other than Keycloak for now. 

## Step 2 - Edit your .env file


```yaml
JWT-AUTHORITY=http://xxx.xxx.xxx.xxx:9001/auth/realms/openrmf
JWT-CLIENT=openrmf
```

## Step 3 - Run the OpenRMF Start script

Then you can open a local browser to http://{ip-address}:8080/ and see what happens.

> The data is currently mapped to internal Docker-managed volumes for persistence. You can run the "docker volume rm" command below if you wish to remove and start over as you test.  If you want persistence you could change the connection strings to another MongoDB server and adjust the docker-compose.yml accordingly. Or use a volume in your docker-compose.yml or individual docker commands. 

## Step 4 - Add a new System 



## Step 5 - Add some Checklist files or SCAP scan results



## Step 6 - Open the System and List Checklists


## Step 7 - Run Reports and Compliance




## Run OpenRMF latest development
For those that want to run the actual "latest" or "edge" of OpenRMF you should run `git clone https://github.com/Cingulara/openrmf-docs.git `, then `git checkout develop` to switch to the develop branch. Inside the scripts directory there is an [edge](scripts/edge/) directory with ./dev-start.sh (or .\dev-start.cmd on Windows) file to run to start and a corresponding ./dev-stop.sh (.\dev-stop.cmd on Windows) to run the latest development version. These operate on http://{ip-address}:8080 as well. Note the docker-compose.yml has different database mount volumes as well. 

This would take the place of Step 3 above. All the rest of the steps are the same in the right order. 