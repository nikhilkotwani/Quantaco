provider "google" {
  project = var.project_id
  region  = var.region
}

resource "google_storage_bucket" "user_bucket" {
  name     = "${var.bucket_prefix}-${var.user_name}"
  location = var.region
  lifecycle_rule {
    condition {
      age = var.lifecycle_age
    }
    action {
      type = "Delete"
    }
  }
  force_destroy = true
}
