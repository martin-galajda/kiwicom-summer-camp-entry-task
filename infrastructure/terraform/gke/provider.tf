# Provider Configuration

terraform {
  required_version = "~> 0.12.2"

  backend "gcs" {
    bucket  = "kiwicomsummercamp-tf-state"
    prefix  = "terraform/state"
  }
}

provider "google" {
  project     = "core-outcome-244717"
  region      = "europe-west2"
}
