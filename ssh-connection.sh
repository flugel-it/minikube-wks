#!/usr/bin/env bash

AWS_PROPERTIES='aws.properties'
source ${AWS_PROPERTIES}

echo "Getting a Public IP"
PUBLIC_IP=$(aws ec2  describe-instances --region ${REGION}  --filters "Name=tag-key,Values=Name,Name=tag-value,Values=${TAG_NAME}" --query "Reservations[*].Instances[*].PublicIpAddress" --output=text)

cat << EOF >> ${AWS_PROPERTIES}
PUBLIC_IP="${PUBLIC_IP}"
EOF

source ${AWS_PROPERTIES}

function executeRemoteCommand() {
    local command=${1}
    ssh -i key/id_rsa -o StrictHostKeyChecking=no ubuntu@${PUBLIC_IP} "${command}"
}

executeRemoteCommand "sudo minikube start --vm-driver=none && sudo minikube status"
sleep 5
executeRemoteCommand "sudo kubectl get nodes && sudo kubectl create namespace minikube-wks"
sleep 2
executeRemoteCommand "sudo kubectl run hello-minikube --image=k8s.gcr.io/echoserver:1.4 --port=8080 --namespace=minikube-wks"
sleep 5
executeRemoteCommand "sudo kubectl expose deployment hello-minikube --type=NodePort --namespace=minikube-wks"
sleep 5
executeRemoteCommand "sudo kubectl get pod --namespace=minikube-wks"
