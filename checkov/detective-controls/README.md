# Épico Detective Controls — Controles Detectivos

Regras que garantem **auditoria e visibilidade** (trilhas, configuração e detecção
de ameaças) para permitir investigação e resposta.

> Regras **built-in** do Checkov; lista efetiva em `checks.txt`.

| Check ID | Recurso | O que valida | Esperado (para passar) |
|---|---|---|---|
| **CKV_AWS_67** | `aws_cloudtrail` | CloudTrail habilitado em todas as regiões | `is_multi_region_trail = true` |
| **CKV_AWS_35** | `aws_cloudtrail` | Logs do CloudTrail cifrados com **KMS CMK** | `kms_key_id` definido |
| **CKV_AWS_36** | `aws_cloudtrail` | Validação de integridade dos arquivos de log | `enable_log_file_validation = true` |
| **CKV_AWS_121** | `aws_config_configuration_aggregator` | AWS Config habilitado em todas as regiões | `account_aggregation_source`/`all_regions = true` |
| **CKV_AWS_238** | `aws_guardduty_detector` | GuardDuty habilitado | `enable = true` |

## O que é esperado do desenvolvedor
- CloudTrail **multi-região**, **cifrado com CMK** e com **validação de integridade**.
- AWS Config cobrindo todas as regiões.
- GuardDuty ativo para detecção de ameaças.

## Catálogo completo de regras built-in deste épico

As regras acima são as **curadas** (aplicadas pelo gate via `checks.txt`). O Checkov
oferece muitas outras built-in para este domínio — a lista completa (ID, recurso e
descrição) está em **[CATALOG.md](./CATALOG.md)**, gerada por `scripts/generate-catalog.sh`.
Para passar a exigir uma delas, adicione o ID ao `checks.txt` deste diretório.
