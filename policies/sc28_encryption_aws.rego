package compliance.sc28_aws
import rego.v1

deny contains msg if {
    some r in input.configuration.root_module.resources
    r.type == "aws_s3_bucket"
    not has_encryption(r.name)
    msg := sprintf("[SC-28] aws_s3_bucket.%s: missing encryption configuration.", [r.name])
}

has_encryption(name) if {
    some r in input.configuration.root_module.resources
    r.type == "aws_s3_bucket_server_side_encryption_configuration"
    some ref in r.expressions.bucket.references
    contains(ref, name)
}