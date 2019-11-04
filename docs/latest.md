---
title: Run Latest Development
nav_order: 1000
---

# Running the Latest Development OpenRMF

To run the latest development version of OpenRMF, you can connect to the openrmf-docs GitHub repo as below. Open a command prompt / terminal window and enter that command below:

```
git clone https://github.com/Cingulara/openrmf-docs.git
```

Next, in the terminal window run <git checkout develop> so you are in the right branch.

## Run Keycloak
To run a local keycloak, go to the scripts/keycloak directory and run the `./startup.sh` or `./startup.cmd` to load Keycloak loally. Then follow the steps below to run Keycloak correctly. The docker-compose used persists the Keycloak database. So once this is setup you should be good to go.  

Note you need to use the IP to reference Keycloak and the OpenRMF tool locally. "Localhost" in the concept of a container is itself, not your local machine! I have stumbled on that so many times....so putting it here now. 

1. Log in to your Keycloak instance, whether online or within containers (docker, kubernetes) or natively on your machine
2. Create a new Realm for openrmf
3. In General update the Display Name and make sure Enabled is turn to ON
4. Click Save
5. Go to Login and set User Registration to ON if you wish
6. Set Require SSL appropriately (i.e. none for development locally only)
7. Set any other options you wish and click Save
8. Click on Authentication in the left menu
9. Click the Password Policy tab and set all appropriate policies (digits, special characters, upper and lower case, expiration, etc.)
10. Click Save to set all password policies
11. Click Roles on the far left menu
12. Add the following roles: Administrator, Assessor, Download, Editor, Reader (use proper case)
13. Go to the Default Roles tab and add the Reader role, so new users can at least get Reader (if you wish)
14. Click on Clients on the far left menu
15. Click the Create Button to make a new client
16. Name it `openrmf` and make sure openid-connect is the client protocol
17. Click the Save button
18. Add the Name and Description fields
19. Set the access type to public
20. Disable the Direct Access Grants
21. Setup the Valid Redirect URIs to where your OpenRMF main root URL is (i.e. http://{ip-address}:8080/*)
22. Set the Web Origins appropriately for CORS (i.e. development could be * or your specific URL)
23. Click the Save button to save this initial setup
24. Click on the Client Scopes tab to ensure the `roles` scope is in the right hand box to pass to OpenRMF upon login
25. Click on the Mappers tab under the openrmf Client
26. Click the Create button
27. Add a roles mapper to use just the `roles` name to pass roles to our application (we do this just in case Keycloak changes something...ours remains as this)
28. Make the JSON type a String (see image below)
29. Save the mapper

Now you are finally done! Check the OpenRMF web application by creating a user and logging in. 

> Remember the Redirect URIs cannot be "localhost" if you are running these components inside Docker. Localhost is local to the docker container!


## Run OpenRMF Latest

While in the develop branch, go to the scripts/edge directory. While in that directory run `./dev-start.sh` or `./dev-start.cmd` for your OS and let it spin up the containers for the database and website. You should see a message on how to go to port 8080 to run the application at the end. 

Remember, use the IP address of your local machine to go to it. It should redirect you to go to Keycloak and login or create a user. Once your user is setup and you can log in, you should see OpenRMF correctly!