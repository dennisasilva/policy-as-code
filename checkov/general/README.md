# Épico General — Não classificados (catch-all)

Regras built-in do Checkov (AWS/Terraform) que a categorização automática
**não conseguiu** encaixar nos épicos principais (IAM, Data Protection,
Infra Security, Detective Controls, Incident Response).

- O `catalog.txt` deste diretório lista essas regras para **triagem**.
- Conforme você as revisar, **mova** cada ID para o `checks.txt`/`catalog.txt`
  do épico mais adequado (ex.: um check de Lambda pode ir para `infra-security`).
- Por padrão, **nada aqui é aplicado** pelo gate (não há `checks.txt` com IDs),
  a menos que se use o modo catálogo completo (`use_full_catalog: true`).

> Objetivo: nenhuma regra "se perde". Tudo que o Checkov oferece fica visível e
> rastreável por épico, pronto para ser promovido ao gate quando fizer sentido.
