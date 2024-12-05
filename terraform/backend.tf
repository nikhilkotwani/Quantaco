terraform {
  backend "gcs" {
    bucket  = "terraform-state-bucket-2024-abcd"
    prefix  = "user_states/"
  }
}


