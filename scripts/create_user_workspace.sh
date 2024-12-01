#!/bin/bash

USER=$1

# Initialize and apply Terraform for the user
cd terraform
pwd
ls -ltr
terraform init -reconfigure -backend-config="prefix=user_states/$USER" || exit 1
terraform plan -var-file="terraform/user_vars/$USER.tfvars" || exit 1
terraform apply -var-file="terraform/user_vars/$USER.tfvars" -auto-approve || exit 1
