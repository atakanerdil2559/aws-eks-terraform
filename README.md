# Deploying AWS EKS Cluster with Terraform 

## Prerequisites: 

* AWS Account with Access to Create EC2 and IAM Resources
* AWS Region with a VPC

#### Step 1: Create EC2 Instance

* Launch [EC2 Instance](https://docs.aws.amazon.com/quickstarts/latest/vmlaunch/step-1-launch-instance.html) your prefered Region

* [Create and Attach IAM Role](https://aws.amazon.com/blogs/security/easily-replace-or-attach-an-iam-role-to-an-existing-ec2-instance-by-using-the-ec2-console/) to EC2

### NOTE: For the test purpose, you can attach "AdministratorAccess". However this is NOT recommmened secuirty best practice. 
[AWS IAM Security Best Practices](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html)

* SSH to EC2 Instance and [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)

#### Step 2: Clone this repository

* git clone <>

* cd <>

#### Step 3: Modify 'terraform.tfvars' file

#### Step 4: Run Terraform 

```
terraform init
```

```
terraform validate
```

```
terraform plan
```

```
terraform apply --auto-approve
```

#### Step 5: Install 'kubectl'

* Installation

[Docs](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux)
```
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
```

* Check Version

```
kubectl version --short --client
```

#### Step 6: Install heptio-authenticator-aws for Amazon EKS

* Installation

```
curl -o heptio-authenticator-aws https://amazon-eks.s3-us-west-2.amazonaws.com/1.10.3/2018-06-05/bin/linux/amd64/heptio-authenticator-aws
```

#### Step 7: Configure 'kubectl'

* Create a directory
```
mkdir ~/.kube
```
* Create a kube configuration file
```
vi ~/.kube/config
```
* Add the following configuration 
```
apiVersion: v1
clusters:
- cluster:
    server: <API server endpoint>
    certificate-authority-data: "<Certificate authority>"
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: heptio-authenticator-aws
      args:
        - "token"
        - "-i"
        - "<cluster-name>"
```
#### NOTE: Replace the following parameters in the config file: 
```
- server: <API server endpoint>
- certificate-authority-data: "<Certificate authority>"
- "<cluster-name>"
```
* export config file
```
export KUBECONFIG=$KUBECONFIG:~/.kube/config
```

* update ~/.bashrc
```
echo 'export KUBECONFIG=$KUBECONFIG:~/.kube/config' >> ~/.bashrc
```

#### Step 8: Verify you can access cluster

```
kubectl get svc
```
Output:
![Alt text](img/cluster-info.png?raw=true "Title")

```
kubectl get nodes
```
Output:
![Alt text](img/node-info.png?raw=true "Title")