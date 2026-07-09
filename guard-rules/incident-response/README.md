# Épico Incident Response — regras cfn-guard (CloudFormation)

Regras `.guard` para canais de notificação/resposta.

| Regra (`.guard`) | Recurso | O que valida | Esperado (para passar) |
|---|---|---|---|
| `sns_encrypted.guard` | `AWS::SNS::Topic` | Tópico SNS cifrado com KMS | `KmsMasterKeyId` presente |

> Equivalente ao Checkov `CKV_AWS_26`.

## O que é esperado
- Canais de notificação (SNS) criptografados com KMS.

## Catálogo (regras gerenciadas)
Para um catálogo gerenciado, use a
**[AWS Guard Rules Registry](https://github.com/aws-cloudformation/aws-guard-rules-registry)**.
Veja [`../README.md`](../README.md).
