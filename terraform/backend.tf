terraform {
  backend "gcs" {
    bucket  = "terraform-state-bucket"
    prefix  = "user_states/"
  }
}
