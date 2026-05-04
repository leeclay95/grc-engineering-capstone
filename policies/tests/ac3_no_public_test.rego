package compliance.ac3_test
import rego.v1
import data.compliance.ac3

compliant_bucket := {"planned_values":{"root_module":{"resources":[{"address":"google_storage_bucket.good","type":"google_storage_bucket","values":{"uniform_bucket_level_access":true,"public_access_prevention":"enforced"}}]}}}
public_bucket := {"planned_values":{"root_module":{"resources":[{"address":"google_storage_bucket.bad","type":"google_storage_bucket","values":{"uniform_bucket_level_access":false,"public_access_prevention":"inherited"}}]}}}

test_compliant_bucket_passes if { count(ac3.deny) == 0 with input as compliant_bucket }
test_public_bucket_fails if { count(ac3.deny) > 0 with input as public_bucket }
