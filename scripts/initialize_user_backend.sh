#!/bin/bash

# Script to initialize Terraform backend for a specific user

USER=$1

# Validate input
if [ -z "$USER" ]; then
    echo "Error: No user provided."
    exit 1
fi

# Variables
CURRENT_DIR=$(pwd)
TFVARS_FILE="${CURRENT_DIR}/terraform/user_vars/${USER}.tfvars"
BACKEND_FILE="${CURRENT_DIR}/terraform/backend.tf"
USER_BACKEND_PREFIX="user_states/${USER}"

# Check if the tfvars file exists
if [ ! -f "$TFVARS_FILE" ]; then
    echo "Error: The tfvars file for user '${USER}' does not exist at ${TFVARS_FILE}."
    exit 1
fi

echo "Initializing backend for user: ${USER}"

# Backup existing backend file
if [ -f "$BACKEND_FILE" ]; then
    cp "$BACKEND_FILE" "${BACKEND_FILE}.bak"
fi

# Dynamically update backend configuration for the user
cat > "$BACKEND_FILE" <<EOL
terraform {
  backend "gcs" {
    bucket  = "terraform-state-bucket-2024-abcd"
    prefix  = "${USER_BACKEND_PREFIX}"
  }
}
EOL

# Navigate to Terraform directory
cd terraform || exit 1

# Reinitialize Terraform backend
terraform init -reconfigure -backend-config="prefix=${USER_BACKEND_PREFIX}" || exit 1

# Restore original backend file if needed
if [ -f "${BACKEND_FILE}.bak" ]; then
    mv "${BACKEND_FILE}.bak" "$BACKEND_FILE"
fi

echo "Backend initialized successfully for user: ${USER}"
