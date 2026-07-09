# cfn-guard — regras para CloudFormation

Este diretório concentra as políticas **[AWS CloudFormation Guard (cfn-guard)](https://github.com/aws-cloudformation/cloudformation-guard)**
para validar templates **CloudFormation** no gate, organizadas por **épico de segurança**.

> **Diferença importante em relação ao Checkov:** o cfn-guard **não tem uma
> biblioteca de regras built-in** (não existe `cfn-guard --list`). As regras são
> **suas** (arquivos `.guard`) **ou** vêm da **AWS Guard Rules Registry** (catálogo
> gerenciado). Por isso aqui não há `catalog.txt`/`CATALOG.md` gerado — o catálogo
> gerenciado é a Registry (seção abaixo).

## Estrutura por épico

```
guard-rules/
├── iam/                 iam_no_admin_wildcard.guard
├── data-protection/     s3_kms_cmk.guard · rds_encrypted.guard
├── infra-security/      sg_no_open_admin_ports.guard
├── detective-controls/  cloudtrail_hardened.guard
├── incident-response/   sns_encrypted.guard
└── <épico>/README.md    o que cada regra valida e o esperado
```

## Como as regras são avaliadas (fluxo do gate)

```
PR aberto no repo consumidor  (com cloudformation_dir configurado)
      │  (evento pull_request)
      ▼
policy-gate.yml  ──uses──▶  reusable-policy-scan.yml (repo central)
      │
      ├─ instala o cfn-guard
      │
      ├─ cfn-guard validate -r guard-rules -d <cloudformation_dir> --show-summary fail
      │        • carrega TODAS as regras .guard do diretório (recursivo, todos os épicos)
      │        • para cada template, avalia as regras cujo recurso existe (via `when ... !empty`)
      │        • acumula as violações
      │
      └─ Qualquer violação → exit != 0 → status check falha → (com branch protection) bloqueia o merge
```

- É **análise estática** do template, antes do deploy.
- Cada regra começa com um filtro do tipo
  `let x = Resources.*[ Type == 'AWS::...' ]` e `rule ... when %x !empty { ... }`,
  de forma que **só avalia quando o template contém aquele recurso** (sem falso positivo).

## Inclusão e exclusão

- **Inclusão:** basta o arquivo `.guard` existir em `guard-rules/` — o gate roda
  todos recursivamente. Adicionar regra = adicionar arquivo no épico.
- **Exclusão de regra:** remova (ou não inclua) o `.guard`. Para desligar o
  cfn-guard por completo em um repo consumidor, deixe `cloudformation_dir` vazio
  na chamada do workflow.
- **Exclusão de caminho:** o consumidor controla **qual diretório** é escaneado
  via `cloudformation_dir`.
- Diferente do Checkov, o cfn-guard **não** tem supressão por comentário inline
  (`#checkov:skip`). Para exceções, escopo a regra com condições `when`
  (ex.: aplicar só a recursos com determinada Tag).

## Catálogo gerenciado — AWS Guard Rules Registry

Para não escrever tudo do zero, use a
**[AWS Guard Rules Registry](https://github.com/aws-cloudformation/aws-guard-rules-registry)**:
um repositório oficial com centenas de regras `.guard` já mapeadas para frameworks
de conformidade (ex.: **CIS AWS Benchmark, PCI-DSS, NIST 800-53, NIST CSF,
FedRAMP, HIPAA**). É o "catálogo" equivalente ao conjunto built-in do Checkov.

Como consumir (exemplo):
1. Baixe o pacote de regras do framework desejado (releases da Registry).
2. Coloque os `.guard` no épico correspondente (ou aponte o `-r` para a pasta deles).
3. Rode `cfn-guard validate -r <pasta> -d <template>`.

> Assim você combina **regras próprias por épico** (este diretório) com o
> **catálogo gerenciado** da Registry, do mesmo jeito que no Checkov combinamos
> `checks.txt` (curado) com o catálogo built-in.

## Adicionando uma regra

1. Crie `guard-rules/<épico>/<nome>.guard` (siga o estilo dos arquivos existentes).
2. Documente na tabela do `README.md` do épico (recurso, o que valida, esperado).
3. Adicione exemplos em `examples/cloudformation/` e cubra no `scripts/test-policies.sh`.
