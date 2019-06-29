# Enabling external-to-k8s-cluster access to your pods

You have a couple choices when you wish to expose your application endpoints out of k8s to your local computer with Minkube. They are outlined below. 

For a regular k8s setup you would have an ingress controller like NGINX or Traefik or even HAProxy to help control ingress matching to services in a similar manner.


## Enabling Minikube Ingress for pod access
Follow the information at https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/ to enable the ingress minikube addon `minikube addons enable ingress` and then expose your pod HTTP path with a /path extension to the main Minikube IP.

* Each service YAML has an ingress.yaml that goes with it, which gives a /* and a hostname off the Minikube IP to that service, which gets you into the pod.

## Enabling external IPs for the pods in Minikube via loadbalancer patch pod

Follow the directions at https://github.com/elsonrodriguez/minikube-lb-patch to get external IPs

* Make sure you have `jq` and if not run `brew install jq` or the equivalent on a Linux box
* Make sure the script that uses the minikube profile has the correct path if you have a named profile for Minikube

## Set the kubectl namespace to openrmf

Run `kubectl config set-context openrmf --namespace=openrmf` where the openrmf after set-context is the named Minikube profile you are using. 

## How I run Minikube

I use a named profile so I can try out things, so I run minikube like this in a .sh file:

```bash
minikube start --kubernetes-version "v1.14.3" \
    --vm-driver virtualbox --disk-size 40GB \
    --cpus 2 --memory 8096 --profile openrmf

```

## Ingress Rules and paths into the APIs

There is a hiden gem here https://github.com/kubernetes/ingress-nginx/blob/master/docs/examples/rewrite/README.md on how to setup the ingress controllers especiall if you have sub paths. This below has a $2 in the rewrite target. This means "add the extra stuff on the end". So in this example, if I call http://openrmf.local/controls/healthz/ it will add the /healthz/ to the root of the API call internally. Otherwise it was always just dropping it and calling root no matter what "sub path" of the URL I was calling.

```yaml
apiVersion: extensions/v1beta1
kind: Ingress
metadata:
  name: openrmf-controls-ingress
  namespace: openrmf
  annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/rewrite-target: /$2
    nginx.ingress.kubernetes.io/cors-allow-methods: "GET, OPTIONS"
spec:
  rules:
  - host: openrmf.local
    http:
      paths:
      - path: /controls(/|$)(.*)
        backend:
          serviceName: openrmf-controls
          servicePort: 8080
```