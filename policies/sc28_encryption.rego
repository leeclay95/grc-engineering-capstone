package compliance.sc28
import rego.v1

deny contains msg if {
    some resource in input.planned_values.root_module.resources
    resource.type == "google_storage_bucket"
    not has_cmek(resource)
    msg := sprintf("[SC-28] %s: missing customer-managed encryption key.", [resource.address])
}

has_cmek(resource) if {
    count(resource.values.encryption) > 0
}
