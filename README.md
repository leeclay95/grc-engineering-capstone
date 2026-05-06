# GRC Engineering Capstone Portfolio

This repository demonstrates **Continuous Compliance** and **Automated Governance** across a multi-cloud environment (AWS & GCP). It implements a "Fail-Closed" security model using Infrastructure-as-Code (IaC) and Policy-as-Code (PaC).

##  Compliance Framework: NIST 800-53
All resources and policies in this repository are mapped to specific NIST 800-53 security controls to ensure audit readiness.

* **SC-28 (Protection of Information at Rest):** Mandates Customer-Managed Encryption Keys (CMEK) and SSE-KMS.
* **AC-3 (Access Enforcement):** Automatically blocks public storage buckets and restricts open management ports (SSH/RDP).
* **CM-6 (Configuration Settings):** Enforces mandatory organizational tagging and resource labeling.
* **AU-3/AU-6 (Audit Logging):** Ensures comprehensive access logging and monitoring are enabled by default.



##  Automated Governance (The Security Loop)
This portfolio utilizes a modern DevSecOps pipeline to prevent non-compliant infrastructure from ever reaching the cloud.

1. **Plan:** Terraform generates a binary execution plan.
2. **Audit:** `scripts/policy-gate.sh` uses **Conftest** and **Open Policy Agent (OPA)** to scan the plan against our Rego policy library.
3. **Enforce:** If violations of NIST controls are found, the gate returns a non-zero exit code, effectively blocking the deployment.



## 📂 Project Structure
* **`/policies`**: Rego-based security guardrails for GCP and AWS.
* **`/scripts`**: Automation tools, including the unified `policy-gate.sh` enforcement script.
* **`/modules`**: Reusable, "Compliant-by-Default" infrastructure blueprints.
* **`/evidence`**: Machine-readable JSON evidence (SGE) used for automated audit verification.

### Phase 5: Monitoring & Detection.

* **Lab 5.2: Cloud Security Posture Management (CSPM) Baseline**
    * **SI-4 (Information System Monitoring):** Deployed a dynamic GRC gate using GitHub Actions and OIDC to scan IaC for NIST 800-53 compliance prior to deployment.
    * **SC-28 (Protection of Information at Rest):** Engineered a Customer-Managed Key (CMK) via **AWS KMS** to provide envelope encryption for CloudTrail logs and Config snapshots.
    * **AC-3 (Access Enforcement):** Hardened audit storage by implementing `aws_s3_bucket_public_access_block` and explicit bucket policies for the Config Service Principal.
    * **AU-9 (Audit Storage):** Enabled S3 Versioning and MFA Delete-readiness on all logging buckets to ensure the immutability of the audit trail.
    * **CI/CD Governance:** Integrated **Cosign** for keyless signing of audit evidence, creating a cryptographically verifiable chain of custody for every infrastructure change.


* **Lab 5.4: GCP Security Services Baseline**
    * **AC-2 (Account Management):** Eliminated long-lived service account JSON keys by implementing Workload Identity Federation (WIF), utilizing OIDC to exchange GitHub Actions tokens for short-lived, scoped access tokens.
    * **AU-2 (Event Logging):** Engineered a persistent audit trail by enabling Data Access Logs (`DATA_READ`, `DATA_WRITE`, `ADMIN_READ`) for Cloud Storage, Cloud KMS, and IAM — services where auditing is disabled by default in GCP.
    * **AC-3 (Access Enforcement):** Established an identity-first security posture, ensuring that service account permissions are restricted to `roles/viewer` for the GRC gate, adhering to the principle of least privilege.
    * **IA-2 (Identification and Authentication):** Configured a Workload Identity Pool and Provider with strict `attribute_condition` mappings, ensuring only authorized repositories can impersonate the GCP administrative identity.
    * **Governance Artifacts:** Generated a machine-readable IAM Policy export as formal evidence of logging configuration, satisfying non-repudiation requirements for the Evidence Vault.




#### 🛠️ Technical Challenges & Remediation
* **Remediated "Implicit Deny" on S3:** Troubleshot an `InsufficientDeliveryPolicyException` where the AWS Config Role lacked explicit permissions in the S3 Bucket Policy. Resolved by engineering a specific handshake between the IAM role and the resource-based policy.
* **Monorepo Path Detection:** Refactored the GitHub Actions `grc-gate` to use dynamic path detection (`git diff`) and absolute workspace pathing (`$GITHUB_WORKSPACE`), allowing the security gate to scale across multiple lab environments.
* **Namespace Resolution:** Debugged and corrected the Conftest Python parser to handle nested JSON results, ensuring the security gate accurately counts failures across multi-cloud namespaces.


### Phase 4: CI/CD Enforcement & Evidence

* **Lab 4.4: Evidence Chain of Custody**

* **Cryptographic** Signing: Integrated Cosign to sign audit bundles using keyless OIDC identities.

* **Immutable Storage:** Automated the off-boarding of signed evidence to an AWS S3 Vault with Object Lock (WORM) enabled.

* **Non-Repudiation:** Established a verification process that proves the "who, what, and when" of every infrastructure change without requiring an administrative password.

* **Lab 4.3 (AWS + GitHub Actions):** Automated NIST 800-53 enforcement using a "Fail-Closed" CI/CD pipeline.
    * **OIDC Integration:** Established passwordless trust between GitHub and AWS for secure, secretless authentication.
    * **Automated Gates:** Wired `Conftest` and `tfsec` to scan every Pull Request, blocking non-compliant code from merging.
    * **Exception Registry:** Implemented `.tfsec/config.yml` to centralize and document risk acceptance (CM-3).
    * **Evidence Generation:** Automated the capture of machine-readable audit logs (`sarif`, `json`) as workflow artifacts.

    
### Phase 3: Policy-as-Code & Enforcement
* **Lab 3.4 (Multi-Cloud):** Built a unified automation gate using Conftest to enforce SC-28, AC-3, and CM-6 across both AWS and GCP.
* **Lab 3.3 (GCP):** Developed a NIST-mapped Rego library for Google Cloud Platform.

### Phase 2: Compliant Primitives
* **Lab 2.3 (AWS):** Engineered a secure S3 "Evidence Vault" with Object Lock and Versioning.
* **Lab 2.4 (GCP):** Developed a compliant GCS module featuring KMS encryption and Attestation logic.
* **Lab 2.5 (AWS):** Implemented IaC as Compliance Evidence patterns.

---

