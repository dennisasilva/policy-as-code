# Épico Incident Response — Resposta a Incidentes

Regras que garantem **retenção de logs, notificação, backup e criptografia** dos
componentes usados durante a resposta a incidentes.

> Regras **built-in** do Checkov; lista efetiva em `checks.txt`.

| Check ID | Recurso | O que valida | Esperado (para passar) |
|---|---|---|---|
| **CKV_AWS_166** | `aws_backup_vault` | Backup Vault cifrado com **KMS CMK** | `kms_key_arn` definido |
| **CKV_AWS_26** | `aws_sns_topic` | Tópico SNS criptografado | `kms_master_key_id` definido |
| **CKV_AWS_27** | `aws_sqs_queue` | Fila SQS criptografada | `kms_master_key_id` definido |
| **CKV_AWS_319** | `aws_cloudwatch_metric_alarm` | Ações do alarme habilitadas | `actions_enabled = true` |
| **CKV_AWS_66** | `aws_cloudwatch_log_group` | Log group com retenção definida | `retention_in_days` definido |

## O que é esperado do desenvolvedor
- Canais de notificação (SNS/SQS) **criptografados**.
- **Backups** cifrados com CMK.
- Alarmes com **ações habilitadas** e log groups com **retenção** explícita (evita logs efêmeros).
