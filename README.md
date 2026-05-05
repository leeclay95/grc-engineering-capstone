# GRC Engineering Capstone Portfolio

This repository demonstrates **Continuous Compliance** and **Automated Governance** across a multi-cloud environment (AWS & GCP). It implements a "Fail-Closed" security model using Infrastructure-as-Code (IaC) and Policy-as-Code (PaC).

## 🛡️ Compliance Framework: NIST 800-53
All resources and policies in this repository are mapped to specific NIST 800-53 security controls to ensure audit readiness.

* **SC-28 (Protection of Information at Rest):** Mandates Customer-Managed Encryption Keys (CMEK) and SSE-KMS.
* **AC-3 (Access Enforcement):** Automatically blocks public storage buckets and restricts open management ports (SSH/RDP).
* **CM-6 (Configuration Settings):** Enforces mandatory organizational tagging and resource labeling.
* **AU-3/AU-6 (Audit Logging):** Ensures comprehensive access logging and monitoring are enabled by default.



## 🚀 Automated Governance (The Security Loop)
This portfolio utilizes a modern DevSecOps pipeline to prevent non-compliant infrastructure from ever reaching the cloud.

1. **Plan:** Terraform generates a binary execution plan.
2. **Audit:** `scripts/policy-gate.sh` uses **Conftest** and **Open Policy Agent (OPA)** to scan the plan against our Rego policy library.
3. **Enforce:** If violations of NIST controls are found, the gate returns a non-zero exit code, effectively blocking the deployment.



## 📂 Project Structure
* **`/policies`**: Rego-based security guardrails for GCP and AWS.
* **`/scripts`**: Automation tools, including the unified `policy-gate.sh` enforcement script.
* **`/modules`**: Reusable, "Compliant-by-Default" infrastructure blueprints.
* **`/evidence`**: Machine-readable JSON evidence (SGE) used for automated audit verification.


### Phase 3: Policy-as-Code & Enforcement
* **Lab 3.4 (Multi-Cloud):** Built a unified automation gate using Conftest to enforce SC-28, AC-3, and CM-6 across both AWS and GCP.
* **Lab 3.3 (GCP):** Developed a NIST-mapped Rego library for Google Cloud Platform.

### Phase 2: Compliant Primitives
* **Lab 2.3 (AWS):** Engineered a secure S3 "Evidence Vault" with Object Lock and Versioning.
* **Lab 2.4 (GCP):** Developed a compliant GCS module featuring KMS encryption and Attestation logic.
* **Lab 2.5 (AWS):** Implemented IaC as Compliance Evidence patterns.

---

