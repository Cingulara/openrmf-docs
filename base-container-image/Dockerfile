# build runtime image
FROM alpine:3.12.0
RUN apk update && apk upgrade && apk add ca-certificates openssh libstdc++ libintl icu && rm -rf /var/cache/apk/*
# these are only needed for REL libunwind nghttp2-libs libidn krb5-libs libuuid lttng-ust zlib 
# copy all the DoD CA certs and PEM files to import
COPY ./ca-root/ /usr/local/share/ca-certificates/
RUN update-ca-certificates