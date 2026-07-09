# Épico IAM — regras cfn-guard (CloudFormation)

Regras `.guard` para políticas/permissões IAM em templates CloudFormation.

| Regra (`.guard`) | Recurso | O que valida | Esperado (para passar) |
|---|---|---|---|
| `iam_no_admin_wildcard.guard` | `AWS::IAM::ManagedPolicy` | Statement `Allow` com `Action: '*'` **e** `Resource: '*'` (admin total) | Nenhuma statement concede `Action` e `Resource` ambos `'*'` |

> Equivalente ao Checkov `CKV_AWS_1`.

## O que é esperado
- Políticas com menor privilégio: `Action`/`Resource` específicos.
- Nunca `Action: '*'` combinado com `Resource: '*'`.

## Catálogo (regras gerenciadas)
O cfn-guard **não tem regras built-in**. Para um catálogo gerenciado de IAM, use a
**[AWS Guard Rules Registry](https://github.com/aws-cloudformation/aws-guard-rules-registry)**
(mapeada por frameworks: CIS, PCI, NIST…). Veja [`../README.md`](../README.md).
