# Épico Data Protection — regras cfn-guard (CloudFormation)

Regras `.guard` de criptografia e não-exposição de dados.

| Regra (`.guard`) | Recurso | O que valida | Esperado (para passar) |
|---|---|---|---|
| `s3_kms_cmk.guard` | `AWS::S3::Bucket` | Bucket cifrado com **KMS CMK** (não AES256) | `BucketEncryption` com `SSEAlgorithm == 'aws:kms'` **e** `KMSMasterKeyID` |
| `rds_encrypted.guard` | `AWS::RDS::DBInstance` | RDS cifrado e não público | `StorageEncrypted == true` **e** `PubliclyAccessible == false` |

> Equivalentes aos Checkov `CKV2_PAC_1` (S3 CMK), `CKV_AWS_16` e `CKV_AWS_17` (RDS).

## O que é esperado
- Criptografia em repouso sempre; com **CMK** onde houver requisito de governança.
- Bancos nunca públicos.

## Catálogo (regras gerenciadas)
Para um catálogo gerenciado, use a
**[AWS Guard Rules Registry](https://github.com/aws-cloudformation/aws-guard-rules-registry)**.
Veja [`../README.md`](../README.md).
