#!/usr/bin/env bash

echo "Use local aws credential? (yes / no)"
read OPTION

if [ ${OPTION} == 'yes' ]; then
    packer build template.json
elif [ ${OPTION} == 'no' ]; then
   echo "Enter the AWS_ACCESS_KEY"
   read AWS_ACCESS_KEY
   echo "Enter the AWS_SECRET_ACCESS_KEY"
   read AWS_SECRET_ACCESS_KEY
   export AWS_ACCESS_KEY_ID="${AWS_ACCESS_KEY}"
   export AWS_SECRET_ACCESS_KEY="${AWS_SECRET_ACCESS_KEY}"
   export AWS_DEFAULT_REGION="${REGION}"
   
   packer build -var aws_access_key="${AWS_ACCESS_KEY}" -var aws_secret_key="${AWS_SECRET_ACCESS_KEY}" template.json
else
    exit 1
fi
