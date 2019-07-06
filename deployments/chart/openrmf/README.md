# Using Helm and Tiller to deploy OpenRMF into kubernetes (k8s)

If you have helm and tiller setup you can use the helm command with the charts and values supplied
to setup the OpenRMF demo within k8s. The values.yaml file has the DNS name of what you want the 
main URL to be to use the demo via HTTP. For now that is the only real value needed. 

To install Helm into your cluster see https://helm.sh/docs/using_helm/.

## Steps to install the OpenRMF Demo

1. Run `kubectl apply -f ./deployments/kubernetes/namespace.yaml`from the root folder within the repo.
2. Run `helm install ./deployments/chart/openrmf`from the root folder within the root folder.
3. Verify by going to the HTTP path shown after a successful helm install to verify it is working.

## Values.yaml for your MUX AEW install

The values.yaml file has only one field for now. It is the DNS name that you want the ingress to respond to. This can be a DNS pointer to the IP of your k8s installation. It also could be the `minikube ip` for a local  install setup in your /etc/hosts file. Whichever it is, make the name match DNS so your deployment can be accessed via a web browser.