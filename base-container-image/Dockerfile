# build runtime image
FROM mcr.microsoft.com/dotnet/core/aspnet:3.1
RUN apt-get update && apt-get -y upgrade && apt-get -y dist-upgrade && apt-get -y install ca-certificates &&  apt-get clean
# copy all the DoD CA certs and PEM files to import
COPY ./ca-root/ /usr/local/share/ca-certificates/
RUN update-ca-certificates