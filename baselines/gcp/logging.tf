resource "google_project_iam_audit_config" "audit_logs" {
  project = var.gcp_project
  # Repeat this block for 'cloudkms.googleapis.com' and 'iam.googleapis.com'
  service = "storage.googleapis.com" 
  
  audit_log_config { log_type = "DATA_READ" }
  audit_log_config { log_type = "DATA_WRITE" }
  audit_log_config { log_type = "ADMIN_READ" }
}