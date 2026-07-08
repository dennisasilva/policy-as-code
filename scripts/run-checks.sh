#!/usr/bin/env bash
# Roda as checagens Policy-as-Code localmente contra diretórios informados.
#
# Uso:
#   scripts/run-checks.sh <terraform_dir> [cloudformation_dir]
# Exemplo:
#   scripts/run-checks.sh ./infra ./cfn
set -uo pipefail
cd "$(dirname "$0")/.."

TF_DIR="${1:-.}"
CFN_DIR="${2:-}"
RC=0

echo "== Checkov (Terraform) em: ${TF_DIR} =="
checkov -d "$TF_DIR" --external-checks-dir checkov --check CKV2_PAC_1 --compact || RC=1

if [ -n "$CFN_DIR" ]; then
  echo "== cfn-guard (CloudFormation) em: ${CFN_DIR} =="
  if command -v cfn-guard >/dev/null 2>&1; then
    cfn-guard validate -r guard-rules -d "$CFN_DIR" --show-summary fail || RC=1
  else
    echo "cfn-guard não instalado. Instale: https://github.com/aws-cloudformation/cloudformation-guard"
    RC=1
  fi
fi

exit $RC
