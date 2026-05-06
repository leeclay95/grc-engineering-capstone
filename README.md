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


### Phase 5: Monitoring & Detection (The Auditor's View)

* **Lab 5.2: Cloud Security Posture Management (CSPM) Baseline**
    * **SI-4 (Information System Monitoring):** Deployed AWS Security Hub with the **NIST 800-53 Rev 5** standard subscription.
    * **CM-8 (Information System Component Inventory):** Orchestrated an AWS Config Global Recorder to maintain a near real-time inventory of 50+ resource types.
    * **AU-2 / AU-12 (Audit Logging):** Configured an immutable multi-region **AWS CloudTrail** integrated with S3 for non-repudiation of management events.
    * **Root Cause Analysis (RCA):** Successfully troubleshot and remediated an `InsufficientDeliveryPolicyException` by engineering an explicit IAM-to-S3 handshake in the bucket policy.
    * **Continuous Audit:** Established a "Day 0" findings baseline, identifying a **CRITICAL** deviation in `Config.1` (Identity-based vs Service-Linked Role recording), providing immediate visibility into the account's risk posture.


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

