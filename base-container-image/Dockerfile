# build runtime image
FROM docker.io/alpine:3.21.2
RUN apk update && apk upgrade && apk add --no-cache ca-certificates openssh libstdc++ libintl icu 
# these are only needed for REL libunwind nghttp2-libs libidn krb5-libs libuuid lttng-ust zlib 
# copy all the DoD CA certs and PEM files to import
COPY ./ca-root/ /usr/local/share/ca-certificates/
RUN update-ca-certificates