# Compliance Policy Library (Rego)

This library contains automated guardrails mapped to the NIST 800-53 framework.

| Control | Severity | Enforcement Logic |
| :--- | :--- | :--- |
| **SC-28** | High | Every GCS bucket must have a `encryption` block (CMEK). |
| **AC-3** | Critical | Prevents public access to buckets and open SSH/RDP firewalls. |
| **CM-6** | Medium | Enforces required labels: project, environment, managed_by, compliance_scope. |

## Usage
Run the following command to audit a Terraform plan:
`opa eval -d policies/ -i <plan.json> "data.compliance"`


# NIST 800-53 Policy Library (Multi-Cloud)

This library enforces security guardrails for both GCP and AWS.

| Control | ID | GCP Policy | AWS Policy |
| :--- | :--- | :--- | :--- |
| Encryption at Rest | **SC-28** | sc28_encryption.rego | sc28_encryption_aws.rego |
| Access Enforcement | **AC-3** | ac3_no_public.rego | ac3_no_public_aws.rego |
| Configuration Settings | **CM-6** | cm6_required_tags.rego | cm6_required_tags_aws.rego |