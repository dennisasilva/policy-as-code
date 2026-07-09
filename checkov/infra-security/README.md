# Épico Infra Security — Segurança de Rede/Infra

Regras que evitam **exposição de rede** (portas administrativas abertas para a
internet) e endpoints de plano de controle públicos.

> Regras **built-in** do Checkov; lista efetiva em `checks.txt`.

| Check ID | Recurso | O que valida | Esperado (para passar) |
|---|---|---|---|
| **CKV_AWS_24** | `aws_security_group` / rule | Ingress `0.0.0.0/0` na porta **22 (SSH)** | Nenhuma regra liberando SSH para toda a internet |
| **CKV_AWS_25** | `aws_security_group` / rule | Ingress `0.0.0.0/0` na porta **3389 (RDP)** | Nenhuma regra liberando RDP para toda a internet |
| **CKV_AWS_23** | `aws_security_group` / rule | Regras/SG sem `description` | Toda regra e SG com `description` preenchida |
| **CKV_AWS_39** | `aws_eks_cluster` | Endpoint público do EKS habilitado | `vpc_config { endpoint_public_access = false }` |
| **CKV_AWS_38** | `aws_eks_cluster` | Endpoint público do EKS aberto a `0.0.0.0/0` | `public_access_cidrs` restrito (se o público estiver ligado) |

## O que é esperado do desenvolvedor
- Nunca expor **SSH (22)** ou **RDP (3389)** para `0.0.0.0/0` — use bastion, SSM ou CIDRs restritos.
- **EKS**: manter o endpoint **privado** (`endpoint_public_access = false`); se precisar de público, restringir `public_access_cidrs`.
- Documentar todas as regras de security group (`description`).
