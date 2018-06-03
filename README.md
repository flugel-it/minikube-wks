# minikube-wks
Minikube workstation - Launch it quickly in AWS to try Kubernetes

## Step 1 (Required)
- Install packer (Linux)
```
    wget https://releases.hashicorp.com/packer/1.2.4/packer_1.2.4_linux_amd64.zip
    unzip packer_1.2.4_linux_amd64.zip
    sudo mv packer /usr/local/bin/
    packer -v
    rm packer_1.2.4_linux_amd64.zip
```
- Install Packer (Mac)
```
    brew install packer
```

- Install Terraform (Mac)
```
    wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_darwin_amd64.zip
    unzip terraform_0.11.7_darwin_amd64.zip
    sudo mv terraform /usr/local/bin/terraform
    rm terraform_0.11.7_darwin_amd64.zip
```
- Install Terraform (Linux)
```
    wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip
    unzip terraform_0.11.7_linux_amd64.zip
    sudo mv terraform /usr/local/bin/terraform
    terraform -version
    rm terraform_0.11.7_linux_amd64.zip
```

## Setp 2 - Create Image using Packer and Instance with Terraform
- Execute script start.sh

## Step 3 - Access Instance with SSH, Start and test Minikube
```
ssh -i key/id_rsa ubunu@18.206.223.132
sudo minikube start --vm-driver=none
sudo kubectl create namespace minikube-wks
sudo kubectl run hello-minikube --image=k8s.gcr.io/echoserver:1.4 --port=8080 --namespace=minikube-wks
sudo kubectl expose deployment hello-minikube --type=NodePort --namespace=minikube-wks
sudo kubectl get pod --namespace=minikube-wks
sudo kubectl describe pod hello-minikube --namespace=minikube-wks
```

# Step 4 - Destoy resouces using terraform
- cd terraform/instance/ && terraform destroy -force