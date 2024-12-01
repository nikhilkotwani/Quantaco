# Quantaco Assignment

# Terraform GCS Bucket Automation for Multiple Users

This project automates the process of creating Google Cloud Storage (GCS) buckets for multiple users using Terraform. Each user has a specific `.tfvars` file defining the parameters for their bucket, and the automation scripts ensure that the necessary resources are created independently for each user.

## Project Structure

- `create-user-workspace.sh`: A script to initialize, plan, and apply Terraform for a specific user.
- `generate_users.sh`: A script that generates Terraform commands for each user and calls `create-user-workspace.sh` for each user.
- `terraform/user_vars/*.tfvars`: User-specific `.tfvars` files that define variables for each user (e.g., `user1.tfvars`).
- `main.tf`: The main Terraform configuration file defining a GCS bucket resource.
- `backend.tf`: Configuration for the backend storage of Terraform's state files.
- `variables.tf`: Variable definitions used throughout the Terraform configurations.
- `.github/workflows/deploy-buckets.yml`: GitHub Actions YAML file that automates the process of deploying the GCS buckets.