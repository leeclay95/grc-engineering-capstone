package compliance.ac3
import rego.v1

deny contains msg if {
    some resource in input.planned_values.root_module.resources
    resource.type == "google_storage_bucket"
    not bucket_locked_down(resource)
    msg := sprintf("[AC-3] %s: bucket allows public access.", [resource.address])
}

bucket_locked_down(r) if {
    r.values.uniform_bucket_level_access == true
    r.values.public_access_prevention == "enforced"
}
