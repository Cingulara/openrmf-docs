# Setup the EKS Cluster for OpenRMF
`eksctl create cluster -f bottlerocket.yaml`

# Setup the K8s namespace and PV
`kubectl apply -f ` for the files in the ./kubernetes folder

# Setup metrics

Run `kubectl apply -f ./metrics-server-0.3.6/deploy/1.8+` to get the metrics server running.  Then run `kubectl get deployment metrics-server -n kube-system` to make sure it is ready.

`helm repo add stable https://kubernetes-charts.storage.googleapis.com` to add all stable helm charts. 

Then run the prometheus operator helm chart https://github.com/helm/charts/tree/master/stable/prometheus-operator with `helm install --generate-name stable/prometheus-operator`.

# Setup Networking

kubectl apply -f https://raw.githubusercontent.com/aws/amazon-vpc-cni-k8s/release-1.6/config/v1.6/calico.yaml

# Setup Jaeger

kubectl create -f https://raw.githubusercontent.com/jaegertracing/jaeger-kubernetes/master/jaeger-production-template.yml

# Example Output

```
[ℹ]  node "ip-192-168-24-42.us-east-2.compute.internal" is ready
[ℹ]  node "ip-192-168-40-179.us-east-2.compute.internal" is ready
[ℹ]  node "ip-192-168-75-107.us-east-2.compute.internal" is ready
```

# Connect to Grafana and Prometheus

`kubectl port-forward -n default prometheus-prometheus-operator-158963-prometheus-0 9090`

`kubectl port-forward -n default deploy/prometheus-operator-1595075655-grafana 3000`

# Storage Driver

aws iam attach-role-policy --policy-arn arn:aws:iam::144701936928:policy/Amazon_EBS_CSI_Driver --role-name eksctl-openrmf-test-nodegroup-ope-NodeInstanceRole-1JRJM8G2NS1VL