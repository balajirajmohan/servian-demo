
# Servian App Demo

This Repo consists of Reusable Infra components based of Terraform HCL that will be used to 
provision Network components like VPC and Compute Engines reqired for running Jenkins and IAM Policy JSON's and Kubernetes Manifests to deploy your Application.

Tech Stacks Used:

1.CI/CD- Jenkins(Optional) 2.Infra Provisioning- Terraform 3.Container Runtime- Docker

## Steps to reproduce:

Login to AWS Console and Create an IAM user with Admin Role.
Download the .csv Crdentials
As a Best Practise, I have configured my Acess Key ID and Secret access key as a ENV Variables and added to the path so that it can support my Terraform
Tools Needs to be installed on Local Machine:

Terraform - https://www.terraform.io/downloads.html -> Windows 64Bit and allow the download. unzip terraform.exe and add the AWS Access Key ID and secret access key to Windows Environment Variables.

Please follow the below steps for deploying the Jenkins Server Using Terraform:

From Local Machine, navigate to servian-demo\Terraform\resource Folder folder and follow the below steps to deploy a Private VPC and EC2 to host your Jenkins Server to do the deployments on your behalf. 

```
terraform init 
terraform validate
terraform plan
terraform apply --auto-approve
```

From Terraform appply output, Please copy the public ip of EC2 vm and type http://<Server-public-ip> to login to Server with port 8080 to access Jenkins and Install Plugins accordingly.

# IAM Role for Kubernetes Service Account
 Amazon EKS supports IAM Roles for Service Accounts (IRSA) that allows cluster operators to map AWS IAM Roles to Kubernetes Service Accounts.

This provides fine-grained permission management for apps that run on EKS and use other AWS services. These could be apps that use S3, any other data services (RDS, MQ, STS, DynamoDB), or Kubernetes components like AWS Load Balancer controller or ExternalDNS.

Let's create an IAM role called eksctl-secret-manager IAM policy to get access to secrets manager in AWS.

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "Stmt1662464324142",
      "Action": [
        "secretsmanager:DescribeSecret",
        "secretsmanager:GetRandomPassword",
        "secretsmanager:GetResourcePolicy",
        "secretsmanager:GetSecretValue",
        "secretsmanager:ListSecretVersionIds",
        "secretsmanager:ListSecrets"
      ],
      "Effect": "Allow",
      "Resource": "arn:aws:secretsmanager:${Region}:${Account}:secret:${SecretId}"
    }
  ]
}

```

## Create a new EKS cluster with a single autoscaling node group.

We will be deploying our EKS Cluster using an utility called EKSCTL which will utilise the existing infrastructure provisioned
via Terraform. 
```
eksctl create cluster -f eks.yaml


```

# How do I handle my secrets for Application?
  I recommend to use AWS Secrets Manager with EKS and we can install csi-driver via helm charts in our EKS cluster
  which would help our EKS Pods connect with AWS Secrets Manager via a Service Account.

  I did not automate the secret creation and have not included in Terraform as I prefer to handle secrets Manually.

```
helm repo add secrets-store-csi-driver https://raw.githubusercontent.com/kubernetes-sigs/secrets-store-csi-driver/master/charts
helm -n kube-system install csi-secrets-store secrets-store-csi-driver/secrets-store-csi-driver

```

# How do I deplpy my Application in EKS?
  Lets Deploy secrets and CSI Dependancies first.

  ```
  kubectl apply -f kube-manifests/secrets/.
  ```
  Once you deployed the secrets, lets deploy the application of Servian.

  ```
  kubectl apply -f kube-manifests/Application/.
  ```


 





