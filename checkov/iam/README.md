# Épico IAM — Identidade e Acesso

Regras aplicadas pelo gate para código IaC que define **políticas e permissões IAM**.
O objetivo é impedir políticas excessivamente permissivas ou que abram caminho para
escalonamento de privilégios, exposição de credenciais e exfiltração de dados.

> As regras abaixo são **built-in do Checkov** e ficam listadas em `checks.txt`
> (é esse arquivo que o gate lê). Para adicionar/remover, edite o `checks.txt`
> e documente aqui.

| Check ID | Recurso | O que valida | Esperado (para passar) |
|---|---|---|---|
| **CKV_AWS_1** | `aws_iam_policy_document` | Política concede privilégios administrativos totais `*:*` | Nenhuma statement com `Effect=Allow`, `Action="*"` e `Resource="*"` |
| **CKV_AWS_107** | `aws_iam_policy_document` | Permite **exposição de credenciais** (ex.: `iam:CreateAccessKey`, `iam:UpdateLoginProfile`) sem restrição | Ações sensíveis de credenciais não liberadas de forma ampla/irrestrita |
| **CKV_AWS_108** | `aws_iam_policy_document` | Permite **exfiltração de dados** (ex.: compartilhar snapshots/AMIs) sem restrição | Sem permissões amplas que habilitem exfiltração |
| **CKV_AWS_110** | `aws_iam_policy_document` | Permite **escalonamento de privilégios** (ex.: `iam:PassRole` + `iam:AttachRolePolicy`) | Sem combinações que permitam escalar privilégios |
| **CKV_AWS_111** | `aws_iam_policy_document` | Permite **acesso de escrita sem constraint** (`Resource="*"` em ações de escrita) | Ações de escrita restritas a recursos específicos ou com `Condition` |

## O que é esperado do desenvolvedor
- Escreva políticas com **menor privilégio**: ações específicas, `Resource` restrito e, quando aplicável, `Condition`.
- Evite `Action = "*"` e `Resource = "*"` juntos.
- Para permissões perigosas (PassRole, criação de chaves, alteração de políticas), sempre restrinja o escopo.
