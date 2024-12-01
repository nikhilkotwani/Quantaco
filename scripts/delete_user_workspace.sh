#!/bin/bash

USER=$1

# Initialize and apply Terraform for the user
CURRENT_DIR=$(pwd)
cd terraform
TFVARS_FILE="${CURRENT_DIR}/terraform/user_vars/${USER}.tfvars"
pwd
ls -ltr

terraform init -reconfigure -backend-config="prefix=user_states/${USER}" || exit 1
terraform plan -var-file="$TFVARS_FILE" || echo "No resources to destroy for $USER"
terraform destroy -var-file="$TFVARS_FILE" -auto-approve || echo "No resources to destroy for $USER"

