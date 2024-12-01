#!/bin/bash

$deleted_users=$1

# Generates user-specific Terraform commands
CURRENT_DIR=$(pwd)
for user in $deleted_users; do
 if [! -f "${CURRENT_DIR}/user_vars/${user}.tfvars"]; then 
    user=$(basename "$user_file" .tfvars)
    echo "Deleting $user..."
    ./scripts/delete_user_workspace.sh "$user"
  fi  
done
