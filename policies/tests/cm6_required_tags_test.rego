package compliance.cm6_test
import rego.v1
import data.compliance.cm6

complete := {"planned_values":{"root_module":{"resources":[{"address":"google_storage_bucket.good","type":"google_storage_bucket","values":{"labels":{"project":"x","environment":"dev","managed_by":"terraform","compliance_scope":"cge-p-lab"}}}]}}}
missing := {"planned_values":{"root_module":{"resources":[{"address":"google_storage_bucket.bad","type":"google_storage_bucket","values":{"labels":{"project":"x"}}}]}}}

test_complete_passes if { count(cm6.deny) == 0 with input as complete }
test_partial_fails if { count(cm6.deny) > 0 with input as missing }
