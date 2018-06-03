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
   packer build -var aws_access_key="${AWS_ACCESS_KEY}" -var aws_secret_key="${AWS_SECRET_ACCESS_KEY}" template.json
else
    exit 1
fi
