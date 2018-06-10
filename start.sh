#!/usr/bin/env bash

echo "Creating a new private key"
ssh-keygen -f key/id_rsa -t rsa -b 4096 -C "ubuntu@minikube-ks"
chmod 600 key/id_rsa

AWS_PROPERTIES='aws.properties'
PACKER_TEMPLATE='packer/template.json'
EC2_VARIABLES='terraform/instance/variables.tf'

source ${AWS_PROPERTIES}

sed -i "s#<REGION>#${REGION}#g" ${PACKER_TEMPLATE}
sed -i "s#<VPC_ID>#${VPC_ID}#g" ${PACKER_TEMPLATE}
sed -i "s#<SUBNET_ID>#${SUBNET_ID}#g" ${PACKER_TEMPLATE}
sed -i "s#<TAG_NAME>#${TAG_NAME}#g" ${PACKER_TEMPLATE}
sed -i "s#<BASE_AMI>#${BASE_AMI}#g" ${PACKER_TEMPLATE}
sed -i "s#<INSTANCE_TYPE>#${INSTANCE_TYPE}#g" ${PACKER_TEMPLATE}

echo "Creating a new Image using Packer"
(cd packer && ./createImage.sh)

echo "Waiting the AMI will be available!!!"
sleep 30
echo "Getting AMI ID"
AMI_ID=$(aws ec2 describe-images --region ${REGION}  --filters "Name=tag-key,Values=Name,Name=tag-value,Values=${TAG_NAME}" --query 'Images[*].{id:ImageId}' | jq .[].id)

cat << EOF >> ${AWS_PROPERTIES}
AMI_ID=${AMI_ID}
EOF

source ${AWS_PROPERTIES}

sed -i "s#<REGION>#${REGION}#g" ${EC2_VARIABLES}
sed -i "s#<AMI_ID>#${AMI_ID}#g" ${EC2_VARIABLES}
sed -i "s#<INSTANCE_TYPE>#${INSTANCE_TYPE}#g" ${EC2_VARIABLES}
sed -i "s#<TAG_NAME>#${TAG_NAME}#g" ${EC2_VARIABLES}
sed -i "s#<VPC_ID>#${VPC_ID}#g" ${EC2_VARIABLES}
sed -i "s#<SUBNET_ID>#${SUBNET_ID}#g" ${EC2_VARIABLES}


echo "Creating a new Instance with ${AMI_ID}"
(cd terraform/instance; terraform plan; terraform apply -auto-approve)

echo "|-------------------------------------------------------------------------|"
echo "Access the AWS Console to verify the new instance."
echo "https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#Instances:search=Minikube-WKS;sort=instanceState"
echo "To connect on new instance using SSH use the new script ssh-connection.sh"
echo "|-------------------------------------------------------------------------|"