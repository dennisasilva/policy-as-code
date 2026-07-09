# Épico Infra Security — regras cfn-guard (CloudFormation)

Regras `.guard` de segurança de rede.

| Regra (`.guard`) | Recurso | O que valida | Esperado (para passar) |
|---|---|---|---|
| `sg_no_open_admin_ports.guard` | `AWS::EC2::SecurityGroup` | Ingress `0.0.0.0/0` nas portas **22 (SSH)** ou **3389 (RDP)** | Nenhuma regra de ingress libera 22/3389 para `0.0.0.0/0` |

> Equivalente aos Checkov `CKV_AWS_24` / `CKV_AWS_25`.

## O que é esperado
- Portas administrativas (SSH/RDP) nunca abertas para a internet — use bastion/SSM ou CIDRs restritos.

## Catálogo (regras gerenciadas)
Para um catálogo gerenciado, use a
**[AWS Guard Rules Registry](https://github.com/aws-cloudformation/aws-guard-rules-registry)**.
Veja [`../README.md`](../README.md).
