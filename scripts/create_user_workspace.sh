#!/bin/bash

USERIP=$1
$TFSTATE_BUCKET=$2




# Initialize and apply Terraform for the user
CURRENT_DIR=$(pwd)
cd terraform
TFVARS_FILE="${CURRENT_DIR}/terraform/user_vars/${USERIP}.tfvars"
pwd
ls -ltr

# Check if lock exists

for user_file in terraform/user_vars/*.tfvars; do
    USER=$(basename "$user_file" .tfvars)
    PREFIX="user_states/${USER}"
    LOCK_OBJECT="${PREFIX}/default.tflock"
    if gsutil stat "gs://${TFSTATE_BUCKET}/${LOCK_OBJECT}" &>/dev/null; then
        echo "Lock exists for a user state file at ${LOCK_OBJECT}."
        sleep 10
    fi
done

terraform init -reconfigure \
-backend-config="prefix=${PREFIX}" || exit 1

terraform plan -var-file="$TFVARS_FILE" || exit 1
terraform apply -var-file="$TFVARS_FILE" -auto-approve || exit 1


