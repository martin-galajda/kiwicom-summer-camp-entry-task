# Provider Configuration

terraform {
  required_version = "~> 0.12.2"

  backend "gcs" {
    bucket  = "kiwicom-summercamp-tf-state"
    prefix  = "terraform/state"
  }
}

provider "google" {
  project     = "kiwicom-summer-camp-entry-task"
  region      = "europe-west2"
}
