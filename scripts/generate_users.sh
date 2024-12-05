#!/bin/bash

# Generates user-specific Terraform commands
for user_file in terraform/user_vars/*.tfvars; do
  user=$(basename "$user_file" .tfvars)
  echo "Processing $user..."
  ./scripts/create_user_workspace.sh "$user"
done
