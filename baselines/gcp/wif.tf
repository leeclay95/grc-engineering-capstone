# Create the Pool
resource "google_iam_workload_identity_pool" "github" {
  workload_identity_pool_id = "github-actions-pool"
  display_name              = "GitHub Actions Pool"
}

# Create the Provider linked to GitHub
resource "google_iam_workload_identity_pool_provider" "github" {
  project =  var.gcp_project
  workload_identity_pool_id          = google_iam_workload_identity_pool.github.workload_identity_pool_id
  workload_identity_pool_provider_id = "github-provider"

  attribute_mapping = {
    "google.subject"       = "assertion.sub"
    "attribute.repository" = "assertion.repository"
  }

  # CRITICAL: Replace with your actual username/repo
  attribute_condition = "assertion.repository == \"leeclay95/grc-engineering-capstone\""

  oidc { issuer_uri = "https://token.actions.githubusercontent.com" }
}

# Create the Service Account the pipeline will assume
resource "google_service_account" "gha" {
  project = var.gcp_project
  account_id   = "cgep-grc-gate-sa"
  display_name = "GitHub Actions GRC Service Account"
}

# Allow the WIF Pool to "impersonate" the Service Account
resource "google_service_account_iam_binding" "wif_user" {
  service_account_id = google_service_account.gha.name
  role               = "roles/iam.workloadIdentityUser"
  members = [
    "principalSet://iam.googleapis.com/${google_iam_workload_identity_pool.github.name}/attribute.repository/leeclay95/grc-engineering-capstone",
  ]
}