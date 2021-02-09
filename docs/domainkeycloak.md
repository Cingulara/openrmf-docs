---
layout: default
title: Domain Keycloak Setup
nav_order: 1010
---

# Setup Keycloak Using your Existing Keycloak Installation
If you or your company has an existing Keycloak installation you want to use, you can do that as well. There are a few steps to follow to ensure it works correctly. We setup OpenRMF with Keycloak for AuthN/AuthZ and assume it to be running locally along side the OpenRMF stack on port 9001 as a default. 

If you follow these steps below you can make it use your existing Keycloak setup. You also could modify the Keycloak ZIP you download with the OpenRMF release and do something similar to this as well, changing names or ports to run locally instead of 9001.

1. Log out of OpenRMF in your web browser. 
2. Power down the OpenRMF stack with `stop.sh` or `stop.cmd` appropriately.
3. Edit the .env file (it may be hidden) in the directory with the OpenRMF docker files and use the correct URL and client links.

```
JWT-AUTHORITY=https://mykeycloak.mydomain.com/auth/realms/openrmf
JWT-CLIENT=openrmf
```

4. Create a new auth.js file and place in the same directory as the OpenRMF docker-compose file (see below) using your new URL base for Keycloak.

```
var keycloak = Keycloak({
    url: 'https://mykeycloak.mydomain.com/auth/',
    realm: 'openrmf',
    clientId: 'openrmf'
});
```

5. Edit the docker-compose.yml file in the OpenRMF directory and around line 19 where "volumes:" is used you need to add a new entry like below, pointing to your new local auth.js file you just made. It will look very similar to the nginx.conf line. 

```
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
      - ./auth.js:/usr/share/nginx/html/js/auth.js:ro
```

6. Run the `start.sh` or `start.cmd` to bring back up the OpenRMF Stack.
7. Go to your web browser and clear the cache and history to clean up older used OpenRMF files.
8. Refresh your browser and go to the OpenRMF URL that you use. 
9. You should see it go to your new URL for login. 
10. As long as you set it up manually correctly you should be able to login, get your roles, redirect back to OpenRMF and continue on!

> Don't worry, if you mess it up just go back to the https://github.com/Cingulara/openrmf-web/blob/master/js/auth.js main file and copy/paste to start over. 
