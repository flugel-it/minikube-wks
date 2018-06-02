#!/usr/bin/env bash
set -x

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

IMAGE_PROPERTIES='image.properties'

AMI_ID=$(aws ec2 describe-images --filters "Name=tag-key,Values=Name,Name=tag-value,Values=minikube-wks" --query 'Images[*].{ID:ImageId}' | jq .[].ID)

cat <<EOF > ${IMAGE_PROPERTIES}
AMI_ID=${AMI_ID}
EOF