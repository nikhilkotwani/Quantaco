#!/bin/bash

USER=$1
VARS_FILE=$2

# Initialize and apply Terraform for the user
terraform init -chdir=terraform -reconfigure -backend-config="prefix=user_states/${USER}" || exit 1
terraform plan -var-file="$VARS_FILE" || exit 1
terraform apply -var-file="$VARS_FILE" -auto-approve || exit 1
