# minikube-wks
Minikube workstation - Launch it quickly in AWS to try Kubernetes

## Step 1
- Generate SSH-KEY
```
ssh-keygen -f keys/id_rsa -t rsa -b 4096
chmod 400 keys/id_rsa
``` 

## Step 2
- Install packer
```
wget https://releases.hashicorp.com/packer/1.2.4/packer_1.2.4_linux_amd64.zip
unzip packer_1.2.4_linux_amd64.zip 
sudo mv packer /usr/local/bin/
packer -v
rm packer_1.2.4_linux_amd64.zip
```

## Step 3
- Create image with packer
```
packer build -var aws_access_key="<AWS-ACCESS-key>" -var aws_secret_key="<AWS-SECRET-KEY>" template.json
```

## Step 4
- Create instance with Terraform
- TODO