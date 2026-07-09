# Épico Detective Controls — regras cfn-guard (CloudFormation)

Regras `.guard` de auditoria/visibilidade.

| Regra (`.guard`) | Recurso | O que valida | Esperado (para passar) |
|---|---|---|---|
| `cloudtrail_hardened.guard` | `AWS::CloudTrail::Trail` | CloudTrail cifrado, com validação e multi-região | `KMSKeyId` presente, `EnableLogFileValidation == true`, `IsMultiRegionTrail == true` |

> Equivalente aos Checkov `CKV_AWS_35` / `CKV_AWS_36` / `CKV_AWS_67`.

## O que é esperado
- CloudTrail multi-região, cifrado com CMK e com validação de integridade dos logs.

## Catálogo (regras gerenciadas)
Para um catálogo gerenciado, use a
**[AWS Guard Rules Registry](https://github.com/aws-cloudformation/aws-guard-rules-registry)**.
Veja [`../README.md`](../README.md).
