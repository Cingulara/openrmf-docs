# Base Image for OpenRMF APIs using valid DoD Root Certificate Authorities
The DoD uses their own CA root certificates. We need them in the APIs since the APIs call the Keycloak server to validate JWTs. If the Keycloak is using HTTPS using a DoD cert the SSL check will fail without these valid Certs. 

## Create the base image to use in all the APIs

```
docker build -t openrmf-base:1.4 .
```

## How to get the CRT files from the CER files
Use the `openssl` command to get the CRT file you need from the downloaded CER files in the DoD CA ZIP bundle.

```
openssl x509 -inform PEM -in 1-DOD_ID_CA-59.cer -out 1-DOD_ID_CA-59.crt
```

## More Information
Visit https://public.cyber.mil/