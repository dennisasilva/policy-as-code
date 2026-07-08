#!/usr/bin/env bash
# Self-test for the Policy-as-Code rules:
#   - compliant examples MUST pass
#   - non-compliant examples MUST be detected (fail)
# Exits non-zero if any expectation is not met.
set -uo pipefail
cd "$(dirname "$0")/.."

CHECK_ID="CKV2_PAC_1"
FAIL=0

echo "==================================================================="
echo " Checkov (Terraform)  -  custom policy ${CHECK_ID}"
echo "==================================================================="

echo "-- compliant (expect PASS) --"
checkov -d examples/terraform/compliant --external-checks-dir checkov --check "$CHECK_ID" --compact --quiet
if [ $? -eq 0 ]; then echo "OK: compliant passed"; else echo "ERROR: compliant should PASS"; FAIL=1; fi

echo "-- non-compliant (expect FAIL) --"
checkov -d examples/terraform/noncompliant --external-checks-dir checkov --check "$CHECK_ID" --compact --quiet
if [ $? -ne 0 ]; then echo "OK: violation detected"; else echo "ERROR: non-compliant should FAIL"; FAIL=1; fi

echo ""
echo "==================================================================="
echo " cfn-guard (CloudFormation)  -  guard-rules/s3_kms_cmk.guard"
echo "==================================================================="
if command -v cfn-guard >/dev/null 2>&1; then
  echo "-- compliant (expect PASS) --"
  if cfn-guard validate -r guard-rules -d examples/cloudformation/compliant.yaml >/dev/null 2>&1; then
    echo "OK: compliant passed"
  else
    echo "ERROR: compliant should PASS"; FAIL=1
  fi

  echo "-- non-compliant (expect FAIL) --"
  if cfn-guard validate -r guard-rules -d examples/cloudformation/noncompliant.yaml >/dev/null 2>&1; then
    echo "ERROR: non-compliant should FAIL"; FAIL=1
  else
    echo "OK: violation detected"
  fi
else
  echo "(cfn-guard not installed; skipping CloudFormation tests)"
fi

echo ""
if [ "$FAIL" -eq 0 ]; then echo "ALL POLICY TESTS PASSED"; else echo "POLICY TESTS FAILED"; fi
exit $FAIL
