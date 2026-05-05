package compliance.cm6_aws
import rego.v1

required := {"Project", "Environment", "ManagedBy", "ComplianceScope"}

deny contains msg if {
	some r in input.planned_values.root_module.resources
	r.type == "aws_s3_bucket"
	provided := {k | some k; r.values.tags_all[k]}
	missing := required - provided
	count(missing) > 0
	msg := sprintf("[CM-6] %s: missing required tags %v.", [r.address, missing])
}
