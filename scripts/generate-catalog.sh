#!/usr/bin/env bash
###############################################################################
# generate-catalog.sh
#
# Gera, para CADA épico de segurança, o arquivo catalog.txt contendo TODOS os
# checks built-in do Checkov para AWS/Terraform, categorizados por heurística
# (tipo de recurso + descrição).
#
# IMPORTANTE:
#   - catalog.txt = CATÁLOGO de referência (todas as regras disponíveis por épico).
#   - checks.txt  = lista EFETIVAMENTE aplicada pelo gate (curada; você promove
#                   IDs do catálogo para cá conforme adota).
#   - A categorização é automática/heurística: revise e ajuste quando necessário
#     (mover um ID de um épico para outro é só editar os arquivos).
#
# Uso:  bash scripts/generate-catalog.sh
# Requer: checkov instalado (mesma versão usada no gate).
###############################################################################
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CKV_DIR="$ROOT/checkov"
EPICS="iam data-protection infra-security detective-controls incident-response general"

command -v checkov >/dev/null 2>&1 || { echo "ERRO: checkov não instalado." >&2; exit 1; }

TMP="$(mktemp)"
checkov --list 2>/dev/null > "$TMP"

for e in $EPICS; do
  mkdir -p "$CKV_DIR/$e"
  rm -f "$CKV_DIR/$e/.catalog.tmp"
done

# Categoriza cada check (Terraform + recurso aws*) em um épico (primeira regra que casa).
awk -F'|' -v dir="$CKV_DIR" '
function trim(s){ gsub(/^[ \t]+|[ \t]+$/,"",s); return s }
{
  for(i=1;i<=NF;i++) $i=trim($i)
  id=$3; entity=$5; desc=$6; iac=$7
  if(iac!="Terraform") next
  if(entity !~ /^aws/) next
  key=tolower(entity" "desc)

  if(entity ~ /^aws_(iam|cognito|ssoadmin|identitystore)/ || key ~ /(^| )iam |password policy|mfa|access key|assume role|privilege escalation|credentials exposure/)
    epic="iam"
  else if(entity ~ /^aws_(cloudtrail|config|guardduty|securityhub|accessanalyzer|macie|inspector)/ || entity ~ /flow_log/ || entity ~ /^aws_cloudwatch_log_group/ || key ~ /cloudtrail|guardduty|security hub|access analyzer|flow log/)
    epic="detective-controls"
  else if(entity ~ /^aws_(backup|sns|sqs|cloudwatch_metric_alarm)/ || key ~ /backup|sns topic|sqs|metric alarm/)
    epic="incident-response"
  else if(entity ~ /^aws_(s3|kms|db_instance|rds|dynamodb|ebs|efs|fsx|redshift|elasticache|neptune|docdb|secretsmanager|glacier|cloudhsm|dax|qldb|timestream|dlm|ssm_parameter)/ || key ~ /encrypt|at rest|customer managed key|(^| )kms/)
    epic="data-protection"
  else if(entity ~ /^aws_(security_group|vpc|subnet|network_acl|default_|elb|lb|alb|cloudfront|api_gateway|apigatewayv2|wafv2|waf|shield|globalaccelerator|networkfirewall|route_table|nat_gateway|internet_gateway|ec2|instance|eks|ecs|lambda|acm|elasticsearch|opensearch)/ || key ~ /security group|0\.0\.0\.0|public|ingress|egress|(^| )tls|(^| )ssl|https|endpoint/)
    epic="infra-security"
  else
    epic="general"

  print id >> (dir "/" epic "/.catalog.tmp")
}
' "$TMP"

echo "Catálogo gerado por épico:"
for e in $EPICS; do
  f="$CKV_DIR/$e/.catalog.tmp"
  out="$CKV_DIR/$e/catalog.txt"
  {
    echo "# Épico: $e — CATÁLOGO de checks built-in do Checkov (AWS/Terraform)."
    echo "# Gerado por scripts/generate-catalog.sh (a partir de 'checkov --list')."
    echo "# Referência do que EXISTE por épico. A lista APLICADA pelo gate é checks.txt."
    echo "# Para exigir uma regra: mova/adicione o ID em checks.txt (ou use modo catálogo)."
    if [ -f "$f" ]; then sort -u "$f"; fi
  } > "$out"
  rm -f "$f"
  cnt=$(grep -cvE '^[[:space:]]*#|^[[:space:]]*$' "$out" || true)
  printf "  %-20s %s checks\n" "$e" "$cnt"
done

rm -f "$TMP"
echo "OK."
