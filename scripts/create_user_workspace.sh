#!/bin/bash

USERIP=$1

# Initialize and apply Terraform for the user
CURRENT_DIR=$(pwd)
cd terraform
TFVARS_FILE="${CURRENT_DIR}/terraform/user_vars/${USERIP}.tfvars"
pwd
ls -ltr

Check if lock exists
for user_file in terraform/user_vars/*.tfvars; do
DIRECTORY="${CURRENT_DIR}/terraform/user_vars"
find "$DIRECTORY" -type f | while read -r file; do
    USER=$(basename "$file" .tfvars)
    PREFIX="user_states/${USER}"
    LOCK_OBJECT="${PREFIX}/default.tflock"
    if gsutil stat "gs://terraform-state-bucket-2024-abcd/${LOCK_OBJECT}" &>/dev/null; then
        echo "Lock exists for a user state file at ${LOCK_OBJECT}."
        sleep 10
    fi
done


terraform init -reconfigure -backend-config="prefix=user_states/${USERIP}" || exit 1

terraform plan -var-file="$TFVARS_FILE" || exit 1
terraform apply -var-file="$TFVARS_FILE" -auto-approve || exit 1
sleep 10

# Cleanup
echo "Cleaning up temporary files..."
rm -rf .terraform terraform.tfstate terraform.tfstate.backup ~/.terraform.d/plugin-cache


