# Database Image for OpenRMF MongoDB with non root user

Make the mongo DB latest Jammy (Ubuntu) with a non-root user

## Create the base image to use in all the APIs

```
docker build -f ./Dockerfile.MongoDB -t mongo:7.0.32-jammy-nonroot .

docker tag mongo:7.0.32-jammy-nonroot cingulara/mongo:7.0.32-jammy-nonroot

docker push docker.io/cingulara/mongo:7.0.32-jammy-nonroot
```