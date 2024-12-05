#!/bin/bash

USER=$1


# Initialize and apply Terraform for the user
CURRENT_DIR=$(pwd)
cd terraform
TFVARS_FILE="${CURRENT_DIR}/terraform/user_vars/${USER}.tfvars"
pwd
ls -ltr

if [ -f "$LOCK_FILE" ]; then
    echo "Another job is running terraform apply. Waiting..."
    sleep 20
fi


if [ ! -f "$TFVARS_FILE" ]; then
  echo "Error: tfvars file for user '${USER}' does not exist at ${TFVARS_FILE}. Exiting."
  terraform workspace select ${USER} || terraform workspace new ${USER} || exit 1
  terraform plan -var-file="$TFVARS_FILE" || exit 1
  terraform apply -var-file="$TFVARS_FILE" -auto-approve || exit 1
  terraform force-unlock
  cd "$CURRENT_DIR" || exit 1
  echo "Terraform delete applied successfully for user '${USER}'."
fi

