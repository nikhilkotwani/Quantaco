#!/bin/bash

DELETED_USERS=$1

IFS=',' read -r -a USERS <<< "$DELETED_USERS"

# Generates user-specific Terraform commands
CURRENT_DIR=$(pwd)
for USER in "${USERS[@]}"; do
 if [! -f "${CURRENT_DIR}/terraform/user_vars/${USER}.tfvars"]; then 
    echo "Deleting $USER..."
    ./scripts/delete_user_workspace.sh "$USER"
  fi  
done
