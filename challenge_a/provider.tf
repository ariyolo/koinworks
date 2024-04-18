provider "google" {
  credentials = file(var.credentials_file)
  project = var.project_id
  region = var.region
}

terraform {
  required_providers {
    null = {
      source = "hashicorp/null"
      version = "3.2.2"
    }
  }
}