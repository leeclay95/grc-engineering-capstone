package compliance.sc28_test
import rego.v1
import data.compliance.sc28

compliant_input := {"planned_values": {"root_module": {"resources": [{"address": "google_storage_bucket.good","type": "google_storage_bucket","values": {"encryption": [{"default_kms_key_name": "key1"}]}}]}}}
noncompliant_input := {"planned_values": {"root_module": {"resources": [{"address": "google_storage_bucket.bad","type": "google_storage_bucket","values": {"encryption": []}}]}}}

test_compliant_passes if { count(sc28.deny) == 0 with input as compliant_input }
test_noncompliant_fails if { count(sc28.deny) > 0 with input as noncompliant_input }
