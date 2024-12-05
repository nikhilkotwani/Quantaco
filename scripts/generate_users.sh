#!/bin/bash

$TFSTATE_BUCKET=$1

# Generates user-specific Terraform commands
for user_file in terraform/user_vars/*.tfvars; do
  user=$(basename "$user_file" .tfvars)
  echo "Processing $user..."
  ./scripts/create_user_workspace.sh "$user" "$TFSTATE_BUCKET"
done
