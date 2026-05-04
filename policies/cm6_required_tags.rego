package compliance.cm6
import rego.v1

required := {"project", "environment", "managed_by", "compliance_scope"}

deny contains msg if {
    some resource in input.planned_values.root_module.resources
    resource.type == "google_storage_bucket"
    provided := {k | some k; resource.values.labels[k]}
    missing := required - provided
    count(missing) > 0
    msg := sprintf("[CM-6] %s: missing labels %v.", [resource.address, missing])
}
