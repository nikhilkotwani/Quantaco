provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_storage_bucket" "user_bucket" {
  name     = "${var.bucket_prefix}-${var.user_name}"
  location = var.region
  force_destroy = true
}
