variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "US"
}

variable "bucket_prefix" {
  description = "Prefix for bucket names"
  type        = string
}

variable "user_name" {
  description = "Username for the bucket"
  type        = string
}

variable "lifecycle_age" {
  description = "Lifecycle rule: age to delete objects"
  type        = number
  default     = 30
}
