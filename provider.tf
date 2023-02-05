provider "google" {
  project = var.project
  region    = var.region
}

terraform {
  required_providers {
    google = {
      version = "~> 4.0"
    }
  }

  backend "gcs" {}
}