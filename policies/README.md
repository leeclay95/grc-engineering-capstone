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