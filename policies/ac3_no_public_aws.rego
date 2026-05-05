package compliance.ac3_aws
import rego.v1

deny contains msg if {
	bucket := bucket_addresses[_]
	not has_complete_pab(bucket)
	msg := sprintf("[AC-3] %s: missing or incomplete public_access_block.", [bucket])
}

bucket_addresses contains addr if {
	some r in input.configuration.root_module.resources
	r.type == "aws_s3_bucket"
	addr := sprintf("aws_s3_bucket.%s", [r.name])
}

has_complete_pab(bucket_addr) if {
    some r in input.planned_values.root_module.resources
    r.type == "aws_s3_bucket_public_access_block"
    r.values.block_public_acls == true
    r.values.block_public_policy == true
}
