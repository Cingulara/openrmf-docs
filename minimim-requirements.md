# Minimum Resources Required

The installation of OpenRMF<sup>&reg;</sup> OSS requires docker and the docker compose plugin or podman and podman-compose. For Windows 10 and Mac OS X the docker executables are included with the Docker Desktop runtime. The podman and podman-compose executables are container runtime “docker” alternatives created by Red Hat. 

## Minimum docker or podman type executables

For OpenRMF<sup>&reg;</sup> OSS the minimum `docker` and `docker compose` executable version is 20.10.7. Please have at least these versions of software before attempting the installation or upgrade of OpenRMF<sup>&reg;</sup> OSS. The latest docker executable for linux is 20.10 and the latest version of the `docker compose` executable is 2.10 as well. For linux systems please make sure when you install or update docker you include the “docker-compose-plugin” in your apt-get or yum type updates.

The minimum tested `podman` is version 4.2.0 and `podman-compose` is 1.0.3. You can see information here https://medium.com/@dale-bingham-soteriasoftware/how-i-got-my-docker-compose-yml-to-work-switching-to-podman-compose-5252856c6eea on what it takes to run podman and podman-compose with the podman-plugins including `dnsmasq` to get rolling correctly. 

If installing manually, for Linux variants you can install the Docker and Docker Compose package from the appropriate package manager or DockerHub.com. Each Linux OS may have its own documentation for installing Docker. Some Linux platforms can be found through links at https://docs.docker.com/engine/install/. And make sure to enable the docker runtime following the steps listed https://docs.docker.com/engine/install/linux-postinstall/ here.

Alternatively, podman information is available at https://podman.io/ and the podman-compose application can be found at https://github.com/containers/podman-compose as well. 

## Minimum resources to run
The OpenRMF<sup>&reg;</sup> OSS stack uses several database, message, security, and performance services that require good resources.  If you are installing on Mac OS X or Windows native operating systems, you need to check the CPU, memory and swap resources available to your computer and your Docker engine if your version allows that. We recommend a minimum of 6 CPUs and 8 GB of memory for resources. For hard drive space, OpenRMF® Professional uses the files generated, database volumes, and the container images that Docker / Podman downloads.  We recommend 40GB hard drive space for future growth. 

The resources allowed by your laptop, server or virtual machine will differ so please ensure the application performs correctly. Your amount of usage, users, and access may also have you adjust resources to the application based on performance metrics.

Linux environments and the Windows Subsystem Linux (WSL) setting in Windows desktop and server operating systems use memory and CPU within the host settings for Docker. Please see the operating system information on setting CPU and memory usage limits for WSL and Linux as it pertains to Docker and container runtimes. 

## Port Requirements
Make sure port 8080 (or 8443 if you eventually run HTTPS) on your machine is allowed to run, it not running anything else, and is not blocked by firewall from any external machine that wants to use your OpenRMF<sup>&reg;</sup> OSS to connect.

## Persistent Volumes

Note that OpenRMF<sup>&reg;</sup> OSS uses persistent volumes. On Linux those are stored in the /var space so please ensure your hard drive space volumes are large enough to allow OpenRMF<sup>&reg;</sup> OSS and any other applications you run within Docker. With a minimum of 20 GB in the /var partition you will see 60% usage with OpenRMF<sup>&reg;</sup> OSS.

Below is the recommendation on CPU, memory, and HDD for just the software running OpenRMF<sup>&reg;</sup> OSS. 
* 6 CPU cores
* 8 GB Ram
* 40 GB HDD