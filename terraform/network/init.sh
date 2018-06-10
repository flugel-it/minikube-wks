#!/usr/bin/env bash
set -x
PROPERTIES='network.properties'
TF_VAR='variables.tf'

source ${PROPERTIES}

echo "Creating VPC and SubNet"

sed -i "s#<REGION>#${REGION}#g" ${TF_VAR}
sed -i "s#<VPC_TAG_NAME>#${VPC_TAG_NAME}#g" ${TF_VAR}
sed -i "s#<SUBNET_TAG_NAME>#${SUBNET_TAG_NAME}#g" ${TF_VAR}
sed -i "s#<GATEWAY_TAG_NAME>#${GATEWAY_TAG_NAME}#g" ${TF_VAR}
sed -i "s#<ROUTE_TABLE_TAG_NAME>#${ROUTE_TABLE_TAG_NAME}#g" ${TF_VAR}

terraform apply -auto-approve