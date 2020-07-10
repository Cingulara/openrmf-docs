---
layout: default
title: User Profile
nav_order: 900
---

# Your OpenRMF User Profile
Currently, OpenRMF uses Keycloak for AuthN and Authz as well as role based access control (RBAC) for the application. Future releases will be tested against other OpenID providers for other variations to work. You can view the 
See [Run Latest Development](./latest.md) for information on setting up Keycloak. The specific user information for using Keycloak and OpenRMF is below. 

## Register as a User

![OpenRMF Register User](/assets/register-user.png)
You can register as a new user with the registration form. You also can use the GitHub integration on the OpenRMF Demo site to register as well. Enter the pertinent information including a valid email and you are automatically added as a Reader to the application. 

![OpenRMF User Login](/assets/login-page.png)
Once you have a registered account you can login with your user/password combination or the GitHub integration if on the Demo website. 

## User Profile

![OpenRMF User Profile](/assets/view-profile.png)

To access your User Profile from within OpenRMF click the person icon in the very far right top of the application screens. Then click the Profile link. You are redirected to the Keycloak User Profile screen based on your session. From here you can see your account information and update your name and email. 

![OpenRMF User Profile](/assets/account-profile.png)

You also can change your password and see what sessions your account currently has active. 

To return to the OpenRMF application you can click the "Back to OpenRMF Login" in the top right of the screen. Or if you wish, click the Sign Out link to log out. 

## MultiFactor Authentication - Authenticator

![OpenRMF User Profile MFA](/assets/authenticator.png)

For further security, you can setup multifactor authentication in your User Profile area of Keycloak. Log into OpenRMF, go to your profile and then click the Authenticator menu on the left. Use Google Authenticator or FreeOTP to scan the barcode and follow the instructions on the screen to enable MFA. 