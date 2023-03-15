terraform {
  backend "gcs" {
    bucket = "smdainfra-dev-tf-state"
    prefix = "terraform/state"
  }
}