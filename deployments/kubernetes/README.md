# Installing OpenRMF to a Kubernetes instance
This information shows you how to deploy OpenRMF to a Kubernetes instance. I have used this for manually deploying to AWS EKS (outside of ingress) as well as to minikube locally. 

## How I run Minikube

I use a named profile so I can try out things, so I run minikube like this in a .sh file:

```bash
minikube start \
    --vm-driver virtualbox --disk-size 40GB \
    --cpus 3 --memory 8096 --profile openrmf
```

## Optional: Set the kubectl namespace to openrmf

Run `kubectl config set-context openrmf --namespace=openrmf` where the openrmf after set-context is the named Minikube profile you are using. 


# Ingress Options

## Enabling external-to-k8s-cluster access to your pods

You have a couple choices when you wish to expose your application endpoints out of k8s to your local computer with Minkube. They are outlined below. 

For a regular k8s setup you would have an ingress controller like NGINX or Traefik or even HAProxy to help control ingress matching to services in a similar manner.

## Enabling Minikube Ingress for pod access using NGINX
Follow the information at https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/ to enable the ingress minikube addon `minikube addons enable ingress` and then expose your pod HTTP path with a /path extension to the main Minikube IP.

* Each service YAML has an ingress.yaml that goes with it, which gives a /* and a hostname off the Minikube IP to that service, which gets you into the pod.

## Enabling external IPs for the pods in Minikube via loadbalancer patch pod

Follow the directions at https://github.com/elsonrodriguez/minikube-lb-patch to get external IPs

* Make sure you have `jq` and if not run `brew install jq` or the equivalent on a Linux box
* Make sure the script that uses the minikube profile has the correct path if you have a named profile for Minikube

## Ingress Rules and paths into the APIs using NGINX 

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

## How I get this to run locally using DNS (hint: /etc/hosts)

Using the ingress information below where the "host" and the "path" pieces come into play, you can for instance go to http://openrmf.local/web/ and get the web UI. The web.yaml file in here has a ConfigMap that rewrites the API path variables for the web UI to use to call the READ or CONTROLS or COMPLIANCE or UPLOAD API and return data required. All that hinges on the configmap in the web.yaml, the *ingress.yaml files and your /etc/hosts file pointing to the correct IP for "openrmf.local". You can of course change the name, but change it everywhere. And the "IP" to use is found running `minikube ip` if you are using Minikube locally as a "kubernetes cluster of 1".

```yaml
spec:
  rules:
  - host: openrmf.local
    http:
      paths:
      - path: /web(/|$)(.*)
        backend:
          serviceName: openrmf-compliance
          servicePort: 8080
```

## How to setup your k8s to run OpenRMF (manually w/o Heml)
I run all these from the openrmf-docs/kubernetes folder by hand to make sure they are GTG for now. There is also a helm chart to make this easier in a different directory under [deployments](../).

1. Run `kubectl apply -f ./namespace.yaml` to create the OpenRMF namespace area
2. Run `kubectl apply -f ./pv.yaml` to create a persistent volume (if you don't have one to use already)
3. Run `kubectl apply -f ./nats.yaml` to setup NATS 1.4
4. Run `kubectl apply -f ./scoredb.yaml` to setup the Score MongoDB
5. Run `kubectl apply -f ./checklistdb.yaml` to setup the Checklist MongoDB
6. Run `kubectl apply -f ./templatedb.yaml` to setup the Template MongoDB
7. Run `kubectl apply -f ./controls.yaml` to setup the Controls API
8. Run `kubectl apply -f ./compliance.yaml` to setup the Compliance API
9. Run `kubectl apply -f ./read.yaml` to setup the Read API
10. Run `kubectl apply -f ./scoring.yaml` to setup the Scoring API
11. Run `kubectl apply -f ./upload.yaml` to setup the Upload API
12. Run `kubectl apply -f ./web.yaml` to setup the Web UI that calls all the APIs
13. Run `kubectl apply -f ./template.yaml` to setup the Template API
14. Run `kubectl apply -f ./save.yaml` to setup the Save API
15. Run `kubectl apply -f ./scoremsg.yaml` to setup the NATS client for scoring the checklists with eventual consistency
16. Run `kubectl apply -f ./checklistmsg.yaml` to setup the NATS client for retrieving system and checklist information
17. Run `kubectl apply -f ./controlsmsg.yaml` to setup the NATS client for retrieving Controls information
18. Run `kubectl apply -f ./compliancemsg.yaml` to setup the NATS client for generating Compliance information

That sets up all the pieces. Then you have to set the Ingress to talk to them outside of the k8s cluster:
1. Run `kubectl apply -f ./complianceingress.yaml`
2. Run `kubectl apply -f ./controlsingress.yaml`
3. Run `kubectl apply -f ./readingress.yaml`
4. Run `kubectl apply -f ./saveingress.yaml`
5. Run `kubectl apply -f ./scoringingress.yaml`
6. Run `kubectl apply -f ./templateingress.yaml`
7. Run `kubectl apply -f ./uploadingress.yaml`
8. Run `kubectl apply -f ./webingress.yaml`
9. Run `kubectl get ing` to ensure all Ingress are setup with proper hosts and IP Addresses
10. Make sure your "openrmf.local" DNS name (or whatever you changed it to in the YAML) points to your `minikube ip` address.

Other things you can do to make this work well while testing:

1. Run kubectl config set-context openrmf --namespace=openrmf` to set your default namespace if you wish
2. Run `kubectl get pods -o wide` to make sure things are coming up correctly
3. Run `kubectl get pvc` to make sure the persistent volume claims are AOK
4. Run `kubectl describe node minikube` to make sure CPU and disk pressure are not stopping you