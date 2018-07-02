# minikube-wks

Minikube workstation - Set up to be able to run locally or to launch it quickly in AWS to try Kubernetes.

* PS: These package are required to execute this tests.
    - packer
    - terraform
    - jq

## Quick Start

* Clone repo ````git clone````
* Start Vagrant Machine ````vagrant up````
* SSH into Vagrant ````vagrant ssh````
* Start minikube ````minikube start````

## How to use:

### Requirements:
* [Terraform](https://www.terraform.io/downloads.html)
* [Packer](https://www.packer.io/downloads.html)

#### For local usage:
* [Vagrant](https://www.vagrantup.com/docs/installation/)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)


### Usage:

#### Syntax

````$````  local shell
````~$```` inside and SSH session

#### Locally with Vagrant:
The ```Vagrantfile``` is set up to run VirtualBox as the Vagrant provider and Ubuntu 16.04.

##### Step 1:
Execute ````./local-start.sh````.

This script creates the SSH keys, start the vagrant machine, and start an SSH session into the Vagrant enviorement.

##### Step 2:
Start Minikube and make sure it's running
````
~$ sudo minikube start --vm-driver=none
~$ sudo minikube status
````
_Minikube is forced to run with ````--vm-driver=none```` and ````sudo```` due to a VirtualBox [limitation.](https://www.virtualbox.org/ticket/4032)_

##### Step 3:
Stop Minikube and logout from the Vagrant machine.
````
~$ sudo minikube stop
~$ logout
````
If all the testing is done, you can proceed to destroy the Vagrant machine by running in your machine.
````
$ vagrant destroy
````

#### With AWS

##### Step 1
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

##### Step 2 - Access Instance with SSH, Start and test Minikube
- To access the instance and test k8s command use the new script: ssh-connection.sh

##### Step 3 - Destroy EC2 resources with Terraform
- cd terraform/instance/ && terraform destroy -force
