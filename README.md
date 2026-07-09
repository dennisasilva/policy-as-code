# Policy-as-Code — Validação preventiva de IaC

Repositório **central** de regras de _Policy-as-Code_ para validar Infraestrutura como Código **antes do merge** (gate preventivo no Pull/Merge Request), usando:

- **[Checkov](https://www.checkov.io/)** → Terraform (regras custom em YAML)
- **[AWS CloudFormation Guard (cfn-guard)](https://github.com/aws-cloudformation/cloudformation-guard)** → CloudFormation

A validação roda via **GitHub Actions no evento `pull_request`** (não na pipeline de deploy), de modo que mudanças não conformes são barradas antes de chegar à branch de deploy.

> Regra de exemplo incluída: **um bucket S3 deve ser criptografado com uma KMS Customer Managed Key (CMK)** — rejeita SSE-S3 (AES256) e falta de `KMSMasterKeyID`.

> 📘 **Implementação no GitHub + troubleshooting:** veja [`docs/pipeline-implementation.md`](docs/pipeline-implementation.md).

---

## Arquitetura / Fluxo

O repositório central concentra as regras; os repositórios de aplicação **consomem** essas regras na validação do Pull Request (via workflow reutilizável). Não conforme → merge bloqueado; conforme → merge e deploy.

![Fluxo da solução Policy-as-Code](img/architecture.png)

> Diagrama gerado por `img/architecture.py` (biblioteca [`diagrams`](https://diagrams.mingrammer.com/) + Graphviz). Para regerar: `python img/architecture.py`.

---

## Como as regras são avaliadas (fluxo)

O gate roda no **Pull Request** do repositório consumidor e decide, por **análise
estática do IaC** (antes do `terraform apply`), se o código pode ser mergeado.

```
PR aberto no repo consumidor
      │  (evento pull_request)
      ▼
policy-gate.yml  ──uses──▶  reusable-policy-scan.yml (ESTE repo central)
      │
      ├─ 1. Checkout do IaC do PR  +  checkout deste repo de regras
      │
      ├─ 2. MONTA a lista de regras a aplicar (só os IDs; nada roda ainda):
      │
      │        APLICADO = ( checks.txt de cada épico
      │                      [ + catalog.txt de cada épico, se use_full_catalog=true ] )
      │                    − exclusions.txt
      │
      ├─ 3. EXECUTA o scanner:
      │        checkov -d <tf_dir> \
      │                --external-checks-dir checkov \   # carrega built-in + custom (YAML)
      │                --check <APLICADO> \              # aplica só os IDs selecionados
      │                --skip-path <linhas de skip-paths.txt>
      │
      │        • faz o parse do HCL do PR e monta um grafo de recursos
      │        • cada regra avalia SÓ os recursos do seu "scope" (ex.: aws_eks_cluster)
      │        • cada regra devolve PASS / FAIL por recurso
      │
      └─ 4. Qualquer FAIL → exit 1 → o status check "policy / policy-scan" fica VERMELHO
             (com branch protection, isso BLOQUEIA o merge)
```

### O que decide se uma regra roda e se passa
- **Escopo (o quê é avaliado):** a regra só executa se o PR contém um recurso do
  **tipo que ela observa**. Por isso listar regras de serviços não usados **não**
  gera falso positivo — elas simplesmente não avaliam nada.
- **Condições (passa ou falha):** cada regra tem condições sobre atributos do
  recurso. Exemplo da regra custom `CKV2_PAC_1`: sobre
  `aws_s3_bucket_server_side_encryption_configuration`, exige
  `sse_algorithm == "aws:kms"` **E** `kms_master_key_id` presente. Se qualquer
  condição falhar → FAIL.

### Inclusão e exclusão (governança)
| Arquivo | Papel |
|---|---|
| `checkov/<épico>/checks.txt` | **Inclusão curada** — regras efetivamente aplicadas (built-in + custom) |
| `checkov/<épico>/catalog.txt` · `CATALOG.md` | **Catálogo** de todas as built-in do épico (referência) |
| `checkov/exclusions.txt` | **Exclusão de checks** por ID (com justificativa) |
| `checkov/skip-paths.txt` | **Exclusão de caminhos** (`--skip-path`, ex.: `.*/examples/.*`) |
| input `use_full_catalog` | Liga o **modo catálogo completo** (aplica tudo, não só o curado) |

Exceção pontual no consumidor: `#checkov:skip=CKV_AWS_XX:motivo` direto no recurso.

> Detalhes e como promover/excluir regras: [`checkov/README.md`](checkov/README.md)
> e o `README.md` de cada épico em `checkov/<épico>/`.

---

## Estrutura

```
policy-as-code/
├── checkov/                       # regras Checkov (Terraform), organizadas por épico
│   ├── <épico>/                   # iam | detective-controls | infra-security | data-protection | incident-response | general
│   │   ├── checks.txt             #   regras APLICADAS pelo gate (curadas) — built-in + custom
│   │   ├── catalog.txt            #   catálogo (só IDs) de todas as built-in do épico
│   │   ├── CATALOG.md             #   catálogo documentado (ID | recurso | descrição)
│   │   ├── README.md              #   o que cada regra curada valida e o esperado
│   │   └── *.yaml                 #   regras CUSTOM (ex.: data-protection/s3_kms_cmk.yaml = CKV2_PAC_1)
│   ├── exclusions.txt             # IDs a IGNORAR globalmente (subtraídos do conjunto)
│   ├── skip-paths.txt             # caminhos a ignorar no scan (--skip-path)
│   └── README.md                  # mecânica de inclusão/exclusão e catálogo
├── guard-rules/                   # regras cfn-guard (CloudFormation), por épico
│   └── data-protection/s3_kms_cmk.guard
├── examples/
│   ├── terraform/{compliant,noncompliant}/main.tf
│   └── cloudformation/{compliant,noncompliant}.yaml
├── scripts/
│   ├── test-policies.sh           # auto-teste (compliant passa / noncompliant falha)
│   ├── run-checks.sh              # roda as checagens em diretórios informados
│   └── generate-catalog.sh        # (re)gera catalog.txt e CATALOG.md por épico
└── .github/workflows/
    ├── policy-as-code.yml         # auto-teste das regras (no PR deste repo)
    └── reusable-policy-scan.yml   # workflow REUTILIZÁVEL p/ repos consumidores
```

As regras são organizadas por **épico de segurança**: `iam`, `detective-controls`, `infra-security`, `data-protection`, `incident-response` (+ `general` para não classificados). O gate agrega automaticamente os `checks.txt` de todos os épicos (ver seção **Como as regras são avaliadas**).

---

## Como funciona o gate "antes do PR/MR"

1. O repositório **consumidor** adiciona um workflow que chama o workflow reutilizável no evento `pull_request`.
2. Ao abrir/atualizar um PR, o scan roda; se houver violação, o job **falha**.
3. Uma **branch protection rule** marca esse check como **required** → o PR não pode ser mergeado enquanto não estiver conforme. Esse é o ponto preventivo.

### No repositório consumidor (`.github/workflows/policy-gate.yml`)

```yaml
name: Policy Gate
on: pull_request
jobs:
  policy:
    uses: <ORG>/policy-as-code/.github/workflows/reusable-policy-scan.yml@main
    with:
      terraform_dir: "."
      cloudformation_dir: "cfn"   # opcional; vazio = pula CloudFormation
      policy_repo: "<ORG>/policy-as-code"
      policy_ref: "main"
```

Depois, em **Settings → Branches → Branch protection rules**, marque o check `policy-scan` como _Required_.

> Alternativa/adicional: **pre-commit hooks** (Checkov e cfn-guard suportam) para feedback ainda na máquina do desenvolvedor.

---

## Uso local

Pré-requisitos: `pip install checkov` e o [cfn-guard](https://github.com/aws-cloudformation/cloudformation-guard#installation).

```bash
# Auto-teste das regras deste repo (compliant passa, noncompliant falha):
bash scripts/test-policies.sh

# Rodar as checagens contra seus diretórios:
scripts/run-checks.sh ./infra ./cfn
```

---

## A regra de exemplo (S3 exige KMS CMK)

- **Checkov** (`checkov/data-protection/s3_kms_cmk.yaml`, id `CKV2_PAC_1`): no recurso `aws_s3_bucket_server_side_encryption_configuration`, exige `sse_algorithm = "aws:kms"` e `kms_master_key_id` presente.
  Para também rejeitar a chave gerenciada pela AWS (`alias/aws/s3`), acrescente uma condição `not_starting_with: "alias/aws/"`.
- **cfn-guard** (`guard-rules/s3_kms_cmk.guard`): em `AWS::S3::Bucket`, exige `BucketEncryption` com `SSEAlgorithm == 'aws:kms'` e `KMSMasterKeyID` presente.

---

## Adicionando novas regras

- **Terraform/Checkov:** crie um novo `.yaml` na pasta do épico correspondente (ex.: `checkov/iam/`, `checkov/data-protection/`) com um `id` único (padrão `CKV2_PAC_<n>`), e adicione exemplos em `examples/terraform/`.
- **CloudFormation/cfn-guard:** crie um novo `.guard` na pasta do épico em `guard-rules/<epico>/` e exemplos em `examples/cloudformation/`.
- Épicos disponíveis: `iam`, `detective-controls`, `infra-security`, `data-protection`, `incident-response`.
- Atualize `scripts/test-policies.sh` para cobrir a nova regra.

---

## Referências AWS

- AWS Prescriptive Guidance — [Implement centralized custom Checkov scanning](https://docs.aws.amazon.com/prescriptive-guidance/latest/patterns/centralized-custom-checkov-scanning.html)
- [AWS CloudFormation Guard](https://github.com/aws-cloudformation/cloudformation-guard) · [Rules Registry (CIS/PCI/…)](https://github.com/aws-cloudformation/aws-guard-rules-registry)
- Blog — [Extend your pre-commit hooks with AWS CloudFormation Guard](https://aws.amazon.com/blogs/security/extend-your-pre-commit-hooks-with-aws-cloudformation-guard/)
- Blog — [Continuous Compliance Workflow for IaC (Part 2)](https://aws.amazon.com/blogs/devops/continuous-compliance-workflow-for-infrastructure-as-code-part-2/)
