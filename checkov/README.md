# Checkov — regras, inclusão e exclusão

Este diretório organiza as políticas Checkov por **épico de segurança** e define
o que o gate aplica. O mecanismo foi pensado para uso real: começar curado e
crescer, com exceções controladas e auditáveis.

## Estrutura por épico

```
checkov/
├── <épico>/
│   ├── checks.txt      # regras APLICADAS pelo gate (curadas) — built-in + custom
│   ├── catalog.txt     # CATÁLOGO de referência (só IDs): todas as regras built-in do épico
│   ├── CATALOG.md      # CATÁLOGO documentado (ID | recurso | descrição) — gerado
│   ├── README.md       # o que cada regra curada valida e o que é esperado
│   └── *.yaml          # regras CUSTOM (ex.: data-protection/s3_kms_cmk.yaml = CKV2_PAC_1)
├── exclusions.txt      # IDs a IGNORAR globalmente (subtraídos do conjunto)
└── skip-paths.txt      # caminhos a ignorar no scan (--skip-path)
```

Épicos: `iam`, `data-protection`, `infra-security`, `detective-controls`,
`incident-response` e `general` (catch-all de regras ainda não classificadas).

## Como as regras são aplicadas (fluxo do gate)

```
PR aberto no repo consumidor
      │  (evento pull_request)
      ▼
policy-gate.yml  ──uses──▶  reusable-policy-scan.yml (este repo)
      │
      ├─ 1. Checkout do IaC do PR + checkout deste repo de políticas
      │
      ├─ 2. Monta o conjunto de IDs (nada roda ainda):
      │        APLICADO = (checks.txt [+ catalog.txt se use_full_catalog]) − exclusions.txt
      │
      ├─ 3. checkov -d <tf> --external-checks-dir checkov --check <APLICADO> --skip-path <...>
      │        • parse do HCL → grafo de recursos
      │        • carrega checks built-in + custom (YAML)
      │        • filtra para os IDs de --check; ignora os --skip-path
      │        • cada check avalia SÓ os recursos do seu "scope" (ex.: aws_eks_cluster)
      │        • devolve PASS/FAIL por recurso
      │
      └─ 4. Qualquer FAIL → exit 1 → status check "policy / policy-scan" vermelho
```

Pontos-chave:
- É **análise estática** do IaC do PR, **antes** do `terraform apply` (valida o estado desejado, não a nuvem).
- Um check só avalia se o PR contém um recurso do **tipo que ele observa** — por isso listar regras de serviços não usados não gera falso positivo.
- Cada regra tem `scope` (recursos alvo) + condições. Ex. custom `CKV2_PAC_1`: sobre `aws_s3_bucket_server_side_encryption_configuration`, exige `sse_algorithm == "aws:kms"` **E** `kms_master_key_id` existe.

## Como o gate monta o conjunto de regras

```
INCLUDE  = união de todos os checks.txt         (sempre)
         [+ união de todos os catalog.txt]       (se use_full_catalog = true)
EXCLUDE  = exclusions.txt
APLICADO = INCLUDE − EXCLUDE
SCAN     = checkov --check APLICADO --skip-path <cada linha de skip-paths.txt>
```

- **Inclusão (curada):** por padrão, o gate aplica só o que está em `checks.txt`
  de cada épico. É a lista que você faz crescer conforme adota controles.
- **Inclusão (catálogo completo):** chame o workflow com `use_full_catalog: true`
  para aplicar **todas** as regras dos `catalog.txt`. Útil para um "scan amplo"
  ou relatório; tende a ser estrito.
- **Exclusão de check:** adicione o ID em `exclusions.txt` (com justificativa).
  Ele é removido do conjunto, mesmo que esteja em checks.txt/catalog.txt.
- **Exclusão de caminho:** adicione um regex em `skip-paths.txt` (ex.: `.*/examples/.*`).

## Como incluir/promover uma regra

1. Encontre o ID no `catalog.txt` do épico (ou via `checkov --list`).
2. Adicione o ID no `checks.txt` do épico e descreva no `README.md`.
3. No próximo PR, o gate já aplica.

## Exceções pontuais (no repo consumidor)

Além da exclusão global, o desenvolvedor pode suprimir um achado **específico**,
de forma auditável, direto no recurso Terraform:

```hcl
resource "aws_s3_bucket" "legacy" {
  #checkov:skip=CKV2_PAC_1:bucket legado migra para CMK no ticket JIRA-123
  bucket = "..."
}
```

Ou manter um `.checkov.yaml` no próprio repo consumidor para configurações locais.

## Regerar o catálogo

Quando atualizar a versão do Checkov:

```bash
bash scripts/generate-catalog.sh
```

Isso recria os `catalog.txt` de cada épico a partir de `checkov --list`.
A categorização é **heurística** (tipo de recurso + descrição) — revise e mova
IDs entre épicos quando fizer sentido.
