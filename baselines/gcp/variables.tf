variable "gcp_project" {
  type        = string
  description = "The GCP Project ID where resources will be deployed"
  default     = "grc-lab54-1778095737"
}

variable "project_name" {
  type        = string
  description = "Project name passed from the CI/CD pipeline"
  default     = "grc-engineering-capstone"
}