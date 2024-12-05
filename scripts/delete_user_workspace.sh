#!/bin/bash

USER=$1
LOCK_FILE="/tmp/terraform-apply.lock"


# Initialize and apply Terraform for the user
CURRENT_DIR=$(pwd)
cd terraform
TFVARS_FILE="${CURRENT_DIR}/terraform/user_vars/${USER}.tfvars"
pwd
ls -ltr
terraform init -reconfigure -backend-config="prefix=user_states/${USER}" || exit 1
#terraform workspace select ${USER} || terraform workspace new ${USER}
terraform plan -var-file="$TFVARS_FILE" || exit 1

while [ -f "$LOCK_FILE" ]; do
    echo "Another job is running terraform apply. Waiting..."
    sleep 20
done

# Create the lock file
touch "$LOCK_FILE"


terraform apply -var-file="$TFVARS_FILE" -auto-approve || exit 1

rm -f "$LOCK_FILE"

