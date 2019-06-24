# Enabling external-to-k8s-cluster access to your pods

You have a couple choices when you wish to expose your application endpoints out of k8s to your local computer with Minkube. They are outlined below. 


## Enabling Minikube Ingress for pod access
Follow the information at https://medium.com/@awkwardferny/getting-started-with-kubernetes-ingress-nginx-on-minikube-d75e58f52b6c to enable the ingress minikube addon and then expose your pod HTTP path with a /path extension to the main Minikube IP.

* Each service YAML has an ingress.yaml that goes with it, which gives a /path name off the Minikube IP to that service, which gets you into the pod.

## Enabling external IPs for the pods in Minikube via loadbalancer patch pod

Follow the directions at https://github.com/elsonrodriguez/minikube-lb-patch to get external IPs

* Make sure you have `jq` and if not run `brew install jq` or the equivalent on a Linux box
* Make sure the script that uses the minikube profile has the correct path if you have a named profile for Minikube