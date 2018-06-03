#!/usr/bin/env bash
set -x
PROPERTIES='aws.properties'
TF_VAR='terraform/network/variables.tf'
TEMPLATE='template.json'

source ${PROPERTIES}

echo "Creating VPC and SubNet"

sed -i "s#<REGION>#${REGION}#g" ${TF_VAR}
sed -i "s#<VPC_TAG_NAME>#${VPC_TAG_NAME}#g" ${TF_VAR}
sed -i "s#<SUBNET_TAG_NAME>#${SUBNET_TAG_NAME}#g" ${TF_VAR}
sed -i "s#<GATEWAY_TAG_NAME>#${GATEWAY_TAG_NAME}#g" ${TF_VAR}
sed -i "s#<ROUTE_TABLE_TAG_NAME>#${ROUTE_TABLE_TAG_NAME}#g" ${TF_VAR}

cd terraform/network/
terraform apply -auto-approve
cd ../../

echo "Getting vpc id"
VPC_ID=$(aws ec2 describe-vpcs --region ${REGION} --filters "Name=tag-key,Values=Name,Name=tag-value,Values=${VPC_TAG_NAME}" --query 'Vpcs[*].{id:VpcId}' | jq .[].id)
SUBNET_ID=$(aws ec2 describe-subnets --region ${REGION} --filters "Name=tag-key,Values=Name,Name=tag-value,Values=${SUBNET_TAG_NAME}-1" --query 'Subnets[*].{id:SubnetId}' | jq .[].id)

cat << EOF >> 'aws.properties'
VPC_ID=${VPC_ID}
SUBNET_ID=${SUBNET_ID}
EOF

source ${PROPERTIES}
sed -i "s#<REGION>#${REGION}#g" ${TEMPLATE}
sed -i "s#<VPC_ID>#${VPC_ID}#g" ${TEMPLATE}
sed -i "s#<SUBNET_ID>#${SUBNET_ID}#g" ${TEMPLATE}

sed -i "s#<BASE_AMI>#${BASE_AMI}#g" ${TEMPLATE}
sed -i "s#<AMI_NAME>#${AMI_NAME}#g" ${TEMPLATE}
sed -i "s#<INSTANCE_TYPE>#${INSTANCE_TYPE}#g" ${TEMPLATE}

./createImage.sh