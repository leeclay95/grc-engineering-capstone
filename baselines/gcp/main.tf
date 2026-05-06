provider "google" {
  project = var.gcp_project
  region  = "us-east-1"

  user_project_override = true
  billing_project       = var.gcp_project
}

