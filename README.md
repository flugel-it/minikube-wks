# minikube-wks
Minikube workstation - Launch it quickly in AWS to try Kubernetes

* PS: These package are required to execute this tests.
    - packer
    - terraform
    - jq

## Step 1
- Create new IAM using Packer and new EC2 with Terraform
    - 1: Edit the aws.properties file and put the information about your AWS VPC and Subnet, example:
    ```
        REGION="us-east-1"
        VPC_ID="vpc-1c44e464"
        SUBNET_ID="subnet-b81cf797"
        BASE_AMI="ami-80861296"
    ```
    - 2: Execute ./start.sh
    This script make the sed command on Packer template and terraform
    variables changing the many parameters.

## Step 2 - Access Instance with SSH, Start and test Minikube
- To access the instance and test k8s command use the new script: ssh-connection.sh

## Step 3 - Destroy EC2 resources with Terraform
- cd terraform/instance/ && terraform destroy -force