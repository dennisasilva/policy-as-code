# Implementação da checagem via GitHub (Actions) + Troubleshooting

Guia para **ativar a validação Policy-as-Code em um repositório** (gate no Pull Request) e para **diagnosticar problemas** na pipeline.

- Ferramentas: **Checkov** (Terraform) e **AWS CloudFormation Guard / cfn-guard** (CloudFormation).
- Regra de exemplo incluída: `CKV2_PAC_1` — S3 exige KMS CMK.
- Repositório central de regras: **`<ORG>/policy-as-code`** (este repo).

---

## 1. Como funciona (visão geral)

```
Dev abre/atualiza um Pull Request
        │
        ▼
GitHub Actions (on: pull_request) executa o scan
   ├── Checkov  -> Terraform (regras em checkov/**)
   └── cfn-guard -> CloudFormation (regras em guard-rules/**)
        │
   viola? ──► job FALHA (exit ≠ 0)
        │
Branch protection: check "required" ──► merge BLOQUEADO até corrigir
```

O ponto preventivo é a combinação **workflow no `pull_request`** + **required status check** na branch protegida.

---

## 2. Implementação — modo recomendado (workflow reutilizável)

No **repositório consumidor** (que tem o IaC), crie `.github/workflows/policy-gate.yml`:

```yaml
name: Policy Gate
on:
  pull_request:

permissions:
  contents: read

jobs:
  policy:
    uses: <ORG>/policy-as-code/.github/workflows/reusable-policy-scan.yml@v1
    with:
      terraform_dir: "."             # diretório do Terraform (vazio = pula Checkov)
      cloudformation_dir: "cfn"      # diretório do CloudFormation (vazio = pula cfn-guard)
      policy_repo: "<ORG>/policy-as-code"
      policy_ref: "v1"               # fixe uma TAG/branch estável das regras
```

> **Versione as regras:** use uma **tag** (`v1`, `v1.2.0`) em `policy_ref` para não ser surpreendido por mudanças na `main` do repositório de políticas.

## 2b. Modo alternativo (workflow autocontido, sem repo central)

Se preferir não depender de um repo central, copie `checkov/` e `guard-rules/` para o próprio repositório e use um workflow local:

```yaml
name: Policy Gate (self-contained)
on: pull_request
permissions:
  contents: read
jobs:
  scan:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-python@v5
        with: { python-version: "3.12" }
      - run: pip install checkov
      - run: checkov -d . --external-checks-dir checkov --check CKV2_PAC_1 --compact
      - name: Install cfn-guard
        run: |
          curl --proto '=https' --tlsv1.2 -sSf \
            https://raw.githubusercontent.com/aws-cloudformation/cloudformation-guard/main/install-guard.sh | sh
          echo "$HOME/.guard/bin" >> "$GITHUB_PATH"
      - run: cfn-guard validate -r guard-rules -d cfn --show-summary fail
```

---

## 3. Tornar o check obrigatório (branch protection)

1. Rode o workflow ao menos uma vez (abra um PR de teste) para o GitHub “conhecer” o check.
2. Repositório → **Settings → Branches → Add branch protection rule**.
3. Branch name pattern: `main` (ou sua branch de deploy).
4. Marque **Require status checks to pass before merging** e selecione o check:
   - Ao usar o workflow reutilizável, o nome aparece como **`policy / policy-scan`** (`<job-id-no-caller> / <job-id-no-reusable>`).
   - No modo autocontido, o nome é **`scan`**.
5. (Recomendado) Marque **Require branches to be up to date** e **Do not allow bypassing**.

> Não achou o check na lista? Ele só aparece **depois** de ter executado uma vez em um PR. Abra um PR de teste primeiro.

---

## 4. Repositório de políticas privado (permissão cross-repo)

O `actions/checkout` do repo de políticas dentro do reutilizável **precisa de acesso**. O `GITHUB_TOKEN` padrão **não** acessa outro repositório privado. Opções:

- **Mesma organização:** em **Org → Settings → Actions → General**, habilite o compartilhamento de Actions/workflows entre repos da org.
- **Fine-grained PAT** (ou GitHub App token) com permissão de leitura no repo de políticas, salvo como **secret** e passado ao `actions/checkout`:
  ```yaml
  - uses: actions/checkout@v4
    with:
      repository: <ORG>/policy-as-code
      ref: v1
      path: .policy-as-code
      token: ${{ secrets.POLICY_REPO_TOKEN }}
  ```
- Se o repo de políticas for **público**, nada disso é necessário.

---

## 5. Teste local antes de abrir o PR

```bash
# Auto-teste das regras deste repositório (compliant passa / noncompliant falha)
bash scripts/test-policies.sh

# Rodar as regras contra seus diretórios reais
scripts/run-checks.sh ./infra ./cfn
```

Ou instale **pre-commit hooks** (feedback na máquina do dev, antes do commit):
- Checkov: https://www.checkov.io/4.Integrations/pre-commit.html
- cfn-guard: https://aws.amazon.com/blogs/security/extend-your-pre-commit-hooks-with-aws-cloudformation-guard/

---

## 6. Troubleshooting

### 6.1 O workflow não dispara no PR
- O arquivo está em **`.github/workflows/`** e tem `on: pull_request`? (na branch de destino já mergeada, para PRs de forks há restrições).
- O PR aponta para a branch correta? Se usar `on: pull_request: branches: [main]`, PRs para outras branches não disparam.
- Actions está habilitado no repo (**Settings → Actions → General**)?

### 6.2 “Repository not found” / falha no checkout do repo de políticas
- Causa mais comum: repo de políticas **privado** e sem token (ver seção 4).
- Verifique `policy_repo` (`owner/repo`) e `policy_ref` (tag/branch existente).

### 6.3 Falha ao instalar o cfn-guard
- Erro de rede/TLS no script de instalação: fixe uma versão do release do GitHub (`aws-cloudformation/cloudformation-guard/releases`) ou use um runner com o binário pré-instalado.
- Confirme que `echo "$HOME/.guard/bin" >> "$GITHUB_PATH"` foi executado (senão o `cfn-guard` não fica no PATH).

### 6.4 Checkov: a regra custom não é carregada / não “pega”
- Confirme `--external-checks-dir checkov` (caminho relativo correto). As regras são carregadas **recursivamente** dos épicos (`checkov/<epico>/...`).
- Rode com detalhe:
  ```bash
  checkov -d . --external-checks-dir checkov --check CKV2_PAC_1 --compact
  checkov ... --debug        # log detalhado do carregamento das custom policies
  ```
- Se o recurso não é avaliado: confira o **`resource_types`** e o **caminho do atributo** na regra YAML (ex.: `rule.apply_server_side_encryption_by_default.sse_algorithm`).
- **ID duplicado**: cada regra precisa de `id` único (`CKV2_PAC_<n>`). IDs repetidos causam comportamento inesperado.

### 6.5 Interpretação dos exit codes (o que faz o job falhar)
| Ferramenta | Sucesso | Violação | Observação |
|---|---|---|---|
| Checkov | `0` | `1` | `1` = há checks reprovados → **job falha** (esperado) |
| cfn-guard | `0` | não-zero (ex.: `19`) | qualquer não-zero com `--show-summary fail` = violação |

- Um exit **diferente** desses (ex.: erro de sintaxe da regra, arquivo não encontrado) indica **erro de ferramenta/config**, não violação de política — leia o stderr do passo.

### 6.6 Falso-positivo (a regra reprova algo legítimo)
- **Checkov:** suprima pontualmente com comentário inline no recurso, com justificativa:
  ```hcl
  #checkov:skip=CKV2_PAC_1:Bucket de logs usa SSE-S3 por requisito X (aprovado em <ticket>)
  ```
- **cfn-guard:** não tem skip inline; trate via exceção na regra (filtros/`when`) ou mantenha uma lista de exceções documentada. Prefira **ajustar a regra** no repo central via PR.
- Toda exceção deve ter **justificativa registrada** (ticket/description).

### 6.7 Terraform com módulos/variáveis não resolvidos
- O Checkov analisa **HCL estático**. Valores vindos de variáveis/módulos remotos podem não ser resolvidos em tempo de scan, gerando falso-negativo ou avaliação parcial. Para cobertura mais fiel, considere escanear o **plano** (`terraform plan -out` → `terraform show -json` → `checkov -f plan.json`).

### 6.8 Monorepo / performance
- Escaneie apenas os diretórios de IaC (evite `node_modules`, `.terraform`, etc.).
- Para PRs grandes, considere escanear só os **diretórios alterados** (usando `git diff` para montar a lista) e cachear o `pip`.

### 6.9 Onde ver os detalhes do erro
- **Actions → run do workflow → job → passo** que falhou: o log do Checkov mostra `Check ... FAILED for resource ... File: ...:linha`; o cfn-guard mostra `PropertyPath`, `Message` e o trecho do template. Use isso para localizar e corrigir a não conformidade.

---

## 7. Referências
- [AWS Prescriptive Guidance — Centralized custom Checkov scanning](https://docs.aws.amazon.com/prescriptive-guidance/latest/patterns/centralized-custom-checkov-scanning.html)
- [Checkov docs](https://www.checkov.io/) · [AWS CloudFormation Guard](https://github.com/aws-cloudformation/cloudformation-guard)
- [Reusing workflows (GitHub Docs)](https://docs.github.com/actions/using-workflows/reusing-workflows)
