#!/bin/bash

USER=$1

# Initialize and apply Terraform for the user
CURRENT_DIR=$(pwd)
cd terraform
STATE_LIST=$(terraform state list | grep 'google_storage_bucket.user_bucket')
echo $STATE_LIST
TFVARS_FILE="${CURRENT_DIR}/terraform/user_vars/${USER}.tfvars"
pwd
ls -ltr
echo $STATE_LIST

for RESOURCE in $STATE_LIST; do
  USER=$(echo "$RESOURCE" | sed -E 's/.*\["(.*)"\]/\1/')
  if [ ! -f "$TFVARS_FILE" ]; then
    echo "No .tfvars file found for $USER. Removing state for $RESOURCE."
    terraform state rm "$RESOURCE" || exit 1
  fi
done