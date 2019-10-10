# Using Helm to deploy OpenRMF into kubernetes (k8s)

If you have helm and tiller setup you can use the helm command with the charts and values supplied
to setup the OpenRMF demo within k8s. The values.yaml file has the DNS name of what you want the 
main URL to be to use the demo via HTTP. There are other values in there for service types, version of pods, etc. The defaults for most are good to go however the install type, 3 identity provider values, the main namespace, and the DNS name are pretty important to get correct.

To install Helm into your cluster see https://helm.sh/docs/using_helm/. You can use helm and tiller or you can just use helm
locally to setup YAML files you use to deploy later w/o tiller running in your cluster. (I do the latter.)

## Steps to install the OpenRMF Demo

1. Run `kubectl apply -f ./deployments/kubernetes/namespace.yaml`from the root folder within the repo. This makes the namespace to run all the pieces in.
2. For Minikube, run `kubectl apply -f ./deployments/kubernetes/pv.yaml`from the root folder within the repo. This makes the persistent volume to use. Adjust as necessary. Run this only if you need a new PV to use. For AWS or other providers see their 
documentation on making persistent volumes.
3. Run `helm install ./deployments/chart/openrmf`from the root folder within the repo. Optionally, run the `helm template chart/openrmf --output-dir DIR_NAME -n RELEASE_NAME --notes` command to generate valid YAML files to apply to your cluster.
4. Verify by going to the HTTP(S) path shown after a successful helm install to verify it is working.

---

# Values.yaml for your MUX AEW install

The values.yaml file has only 4 fields to configure. The defaults match up to the Keycloak documentation however you can make these whatever you want them to be. 

## main DNS name used to access the deployed app in k8s via DNS through an ingress controller
```yaml
dnsName: openrmf.local
```
It is the DNS name that you want the ingress to respond to. This can be a DNS pointer to the IP of your k8s installation. It also could be the `minikube ip` for a local install setup in your /etc/hosts file. Whichever it is, make the name match DNS so your deployment can be accessed via a web browser.

## The Identity Provider URL and Realm, i.e. using Keycloak for AuthN and AuthZ
```yaml
identityProviderURL: http://192.168.11.22:9001/auth
```
This is the root URL of Keycloak or whatever you want to try and use as the Identity Provider. 

> If you have used Keycloak locally for OpenRMF and switched to Minikube or a DNS name be sure to update your Redirect URI values.

## The Realm to use from the ID provider
```yaml
identityProviderRealm: openrmf
```
This is the Realm name of the Identity Provider.

## The Identity Provider Client Id to use
```yaml
identityProviderClientId: openrmf
```
This is the Client Id within the realm you made for the Identity Provider.

## Namespace to use
The default namespace in k8s is `openrmf`. However, you can make this whatever you want. Create the namespace first, and then run this 
helm chart in that namespace.
```yaml
namespace: openrmf
```

## Installation Type
I have an installation type that has allowable values for `awseks` or `minikube` currently. This is used with an "if" clause for the 
service definitions in the YAML deployments.

```yaml
installType: awseks
```

## Versions of the Container Images to use
Currently the most up-to-date released versions of containers are contained by default in the values. As there are updates and fixes to 
individual images this is updated. Each one can be set individually just in case you wish to use them. They have corresponding GitHub 
repos in the https://www.github.com/Cingulara/ area.

```yaml
checklistdbImage: 0.8
checklistmsgImage: 0.8
complianceImage: 0.8
compliancemsgImage: 0.8
controlImage: 0.8
controlmsgImage: 0.8
readImage: 0.8
saveImage: 0.8
scoredbImage: 0.8
scoremsgmage: 0.8
scoringImage: 0.8
templateImage: 0.8
templatedbImage: 0.8
uploadImage: 0.8
webuiImage: 0.8.1
natsImage: 1.4.1-linux
```

## Persistent Volume Storage Class
The storage class for the persistent volume claims (PVC) for the database containers (for now) is defined in this variable. The default is 
standard. You also can use ebs-sc, efs-sc for AWS or other storage interfaces as they become available for your k8s installation.
```yaml
storageClass: standard
```

## API URLs for the
The Web UI makes client side API calls to APIs with a token for validating user access. These APIs are rewritten with a ConfigMap in k8s 
when you run the web.yaml deployment. These APIs need to be the valid endpoints for the various Read, Score, Upload, etc. API endpoints 
for the Web UI to run correctly. 

In AWS EKS I use them with top level domain names.  If you can run the NGINX Ingress controller or other 
controllers you can use paths and path-based routing.  For Minikube, I stick with the NGINX Ingress controller included as an addon.

```yaml
readAPI:       https://read.openrmf.io
scoreAPI:      https://scoring.openrmf.io
saveAPI:       https://save.openrmf.io
uploadAPI:     https://upload.openrmf.io
templateAPI:   https://template.openrmf.io
complianceAPI: https://compliance.openrmf.io
controlAPI:    https://controls.openrmf.io
```

## Service Types for Service definitions
For now, I have separate "ifF" sections in the Helm chart to setup Services. I did this to separate the whole service section and 
not make it too complex to read with the human eye. And I have 2 separate service types to match that. 

```yaml
serviceTypeMinikube: NodePort
serviceTypeAWS: LoadBalancer
```

## AWS ACM Certificate ARN for HTTPS access
I believe if you put this up in EKS, you need HTTPS. The ACM is extremely easy to either make a new certificate or upload a private one. When you do that you get a resource name like below.  Replace the "x's" and "y's" with the proper identification for your certificate and account to use. 
```yaml
awsACM: arn:aws:acm:us-east-1:xxxxxxxxxxxxxx:certificate/yyyyyyyyyyyyy
```