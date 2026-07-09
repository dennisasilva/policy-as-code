# Épico Data Protection — Proteção de Dados

Regras que garantem **criptografia (preferencialmente com CMK)** e **não exposição**
de dados em repouso nos principais serviços de armazenamento/segredos.

> Inclui a regra **custom** `CKV2_PAC_1` (autoral deste repositório) + regras
> **built-in** do Checkov. A lista efetiva fica em `checks.txt`.

| Check ID | Recurso | O que valida | Esperado (para passar) |
|---|---|---|---|
| **CKV2_PAC_1** (custom) | `aws_s3_bucket_server_side_encryption_configuration` | S3 cifrado com **KMS CMK** (não SSE-S3/AES256) | `sse_algorithm = "aws:kms"` **e** `kms_master_key_id` presente (CMK) |
| **CKV_AWS_16** | `aws_db_instance` | RDS criptografado em repouso | `storage_encrypted = true` |
| **CKV_AWS_17** | `aws_db_instance` | RDS não acessível publicamente | `publicly_accessible = false` |
| **CKV_AWS_149** | `aws_secretsmanager_secret` | Secret cifrado com **KMS CMK** | `kms_key_id` apontando para uma CMK |
| **CKV_AWS_189** | `aws_ebs_volume` | Volume EBS cifrado com **KMS CMK** | `encrypted = true` **e** `kms_key_id` (CMK) |
| **CKV_AWS_33** | `aws_kms_key` | Política da chave sem principal curinga | `policy` sem `Principal = "*"` |

## O que é esperado do desenvolvedor
- **Sempre** criptografar dados em repouso; onde houver requisito de governança, usar **CMK** (não a chave gerenciada pela AWS).
- Nunca expor bancos (`publicly_accessible = false`).
- Políticas de chave KMS sem `Principal = "*"` (evita uso indevido da chave).

## Catálogo completo de regras built-in deste épico

As regras acima são as **curadas** (aplicadas pelo gate via `checks.txt`). O Checkov
oferece muitas outras built-in para este domínio — a lista completa (ID, recurso e
descrição) está em **[CATALOG.md](./CATALOG.md)**, gerada por `scripts/generate-catalog.sh`.
Para passar a exigir uma delas, adicione o ID ao `checks.txt` deste diretório.
