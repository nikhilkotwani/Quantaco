#!/bin/bash

USERIP=$1

# Initialize and apply Terraform for the user
CURRENT_DIR=$(pwd)
cd terraform
TFVARS_FILE="${CURRENT_DIR}/terraform/user_vars/${USERIP}.tfvars"
pwd
ls -ltr

# Check if lock exists
if gsutil stat "gs://terraform-state-bucket-2024-abcd/default.tflock" &>/dev/null; then
    sleep 10
fi


terraform init -reconfigure \
-backend-config="prefix=${PREFIX}" || exit 1

terraform plan -var-file="$TFVARS_FILE" || exit 1
terraform apply -var-file="$TFVARS_FILE" -auto-approve || exit 1


