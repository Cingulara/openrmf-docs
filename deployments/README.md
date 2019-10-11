# Deployments
You can use the Helm chart or do the individual `kubectl` commands from the Kubernetes folder. See the specific information below. Before you start, please make your namespace accordingly. If you do not want your namespace to be `openrmf` adjust the [./kubernetes/namespace.yaml](./kubernetes/namespace.yaml) file and your [./chart/openrmf/namespace.yaml](./chart/openrmf/values.yaml) file for helm.

```
kubectl apply -f ./kubernetes/namespace.yaml
```

## Helm
For deployments using helm see the [chart/openrmf](./chart/openrmf/) folder. There is a values.yaml file that has comments and fields to use. If you wish to use the helm chart to generate the YAML like I do, you can run the following command below from the deployments folder (after you do a git clone or download the code ZIP) to make the files.  You must create the directory to put the files into in the DIR_NAME below.

```
helm template chart/openrmf --output-dir DIR_NAME -n RELEASE_NAME --notes
```
or to put into a single file to deploy
```
helm template chart/openrmf -n RELEASE_NAME --notes > ./openrmf.yaml
```

## Kubernetes
For a straight kubernetes (k8s) installation w/o helm go to the [kubernetes](./kubernetes) folder and make the namespace with the . Then deploy all the pieces locally. You may have to adjust the services based on your setup.

# AWS EKS Specifics

## Setup the Persistent Volume

If you wish to use the Amazon Web Services Kubernetes service EKS, then follow the information here https://docs.aws.amazon.com/eks/latest/userguide/ebs-csi.html to setup a persistent volume to use across your cluster if you have not done so already. The OpenRMF uses persistent volume claims (PVC) to store database data.

* curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-ebs-csi-driver/v0.4.0/docs/example-iam-policy.json
* aws iam create-policy --policy-name Amazon_EBS_CSI_Driver --policy-document file://example-iam-policy.json

Keep a copy of the arn returned: 
* "arn": "arn:aws:iam::xxxxxxxxxxxx:policy/Amazon_EBS_CSI_Driver",

You also an run `kubectl -n kube-system describe configmap aws-auth` to get the information
```
Name:         aws-auth
Namespace:    kube-system
Labels:       <none>
Annotations:  kubectl.kubernetes.io/last-applied-configuration:
                {"apiVersion":"v1","data":{"mapRoles":"- rolearn:  arn:aws:iam::xxxxxxxxxx:role/openrmf-eks-workers-NodeInstanceRole-XXXXXXXX\n  use...

Data
====
mapRoles:
----
- rolearn:  arn:aws:iam::xxxxxxxxx:role/openrmf-eks-workers-NodeInstanceRole-XXXXXXXXXXXXXXX
  username: system:node:{{EC2PrivateDNSName}}
  groups:
    - system:bootstrappers
    - system:nodes

Events:  <none>
```

You then attach the policy to the role so you can use it.

```
aws iam attach-role-policy --policy-arn arn:aws:iam::xxxxxxxx:policy/Amazon_EBS_CSI_Driver --role-name openrmf-eks-workers-NodeInstanceRole-XXXXXXXXXX
```

You then run the following command to setup the PV: 
```
kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/?ref=master"
```

Now you can have a persistent volume claim (PVC) in your deployment YAML files for anything you may need, such as a database or file uploads in your application.

## Add HTTPS to your EKS endpoint

To get https working on your EKS endpoints, read this article: https://aws.amazon.com/premiumsupport/knowledge-center/terminate-https-traffic-eks-acm/. This is the one I got to work successfully every time. And it is what I did in my charts for now while I test others. The issue (read PITA) is the DNS you get from each LoadBalancer, you have to add CNAME records for a TLD to point to them. No path level routing. Not very IaC so still working toward a better solution.

Or if you need path based routing, https://aws.amazon.com/blogs/opensource/kubernetes-ingress-aws-alb-ingress-controller/. And then https://kubernetes-sigs.github.io/aws-alb-ingress-controller/guide/tasks/ssl_redirect/ for the path routing across all pieces.
