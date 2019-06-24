# Enabling external-to-k8s-cluster access to your pods

You have a couple choices when you wish to expose your application endpoints out of k8s to your local computer with Minkube. They are outlined below. 


## Enabling Minikube Ingress for pod access
Follow the information at https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/ to enable the ingress minikube addon `minikube addons enable ingress` and then expose your pod HTTP path with a /path extension to the main Minikube IP.

* Each service YAML has an ingress.yaml that goes with it, which gives a /* and a hostname off the Minikube IP to that service, which gets you into the pod.

## Enabling external IPs for the pods in Minikube via loadbalancer patch pod

Follow the directions at https://github.com/elsonrodriguez/minikube-lb-patch to get external IPs

* Make sure you have `jq` and if not run `brew install jq` or the equivalent on a Linux box
* Make sure the script that uses the minikube profile has the correct path if you have a named profile for Minikube

## Set the kubectl namespace to openrmf

Run `kubectl config set-context --current --namespace=openrmf`.

## How I run Minikube

I use a named profile so I can try out things, so I run minikube like this in a .sh file:

```bash
minikube start --kubernetes-version "v1.14.3" \
    --vm-driver virtualbox --disk-size 40GB \
    --cpus 2 --memory 8096 --profile openrmf

```