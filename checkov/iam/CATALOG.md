# Catálogo built-in — épico `iam`

Regras built-in do Checkov (AWS/Terraform) classificadas neste épico: **37**.
Gerado automaticamente por `scripts/generate-catalog.sh`. A lista **aplicada**
pelo gate é `checks.txt` (curada); este catálogo é referência.

| Check ID | Recurso | O que valida |
|---|---|---|
| CKV_AWS_1 | `aws_iam_policy_document` | Ensure IAM policies that allow full "*-*" administrative privileges are not created |
| CKV_AWS_10 | `aws_iam_account_password_policy` | Ensure IAM password policy requires minimum length of 14 or greater |
| CKV_AWS_107 | `aws_iam_policy_document` | Ensure IAM policies does not allow credentials exposure |
| CKV_AWS_108 | `aws_iam_policy_document` | Ensure IAM policies does not allow data exfiltration |
| CKV_AWS_109 | `aws_iam_policy_document` | Ensure IAM policies does not allow permissions management / resource exposure without constraints |
| CKV_AWS_11 | `aws_iam_account_password_policy` | Ensure IAM password policy requires at least one lowercase letter |
| CKV_AWS_110 | `aws_iam_policy_document` | Ensure IAM policies does not allow privilege escalation |
| CKV_AWS_111 | `aws_iam_policy_document` | Ensure IAM policies does not allow write access without constraints |
| CKV_AWS_12 | `aws_iam_account_password_policy` | Ensure IAM password policy requires at least one number |
| CKV_AWS_13 | `aws_iam_account_password_policy` | Ensure IAM password policy prevents password reuse |
| CKV_AWS_14 | `aws_iam_account_password_policy` | Ensure IAM password policy requires at least one symbol |
| CKV_AWS_15 | `aws_iam_account_password_policy` | Ensure IAM password policy requires at least one uppercase letter |
| CKV_AWS_161 | `aws_db_instance` | Ensure RDS database has IAM authentication enabled |
| CKV_AWS_162 | `aws_rds_cluster` | Ensure RDS cluster has IAM authentication enabled |
| CKV_AWS_273 | `aws_iam_user` | Ensure access is controlled through SSO and not AWS IAM defined users |
| CKV_AWS_274 | `aws_iam_group_policy_attachment` | Disallow IAM roles, users, and groups from using the AWS AdministratorAccess policy |
| CKV_AWS_275 | `aws_iam_policy` | Disallow policies from using the AWS AdministratorAccess policy |
| CKV_AWS_283 | `aws_iam_policy_document` | Ensure no IAM policies documents allow ALL or any AWS principal permissions to the resource |
| CKV_AWS_286 | `aws_iam_group_policy` | Ensure IAM policies does not allow privilege escalation |
| CKV_AWS_287 | `aws_iam_group_policy` | Ensure IAM policies does not allow credentials exposure |
| CKV_AWS_288 | `aws_iam_group_policy` | Ensure IAM policies does not allow data exfiltration |
| CKV_AWS_289 | `aws_iam_group_policy` | Ensure IAM policies does not allow permissions management / resource exposure without constraints |
| CKV_AWS_290 | `aws_iam_group_policy` | Ensure IAM policies does not allow write access without constraints |
| CKV_AWS_348 | `aws_iam_access_key` | Ensure IAM root user does not have Access keys |
| CKV_AWS_355 | `aws_iam_group_policy` | Ensure no IAM policies documents allow "*" as a statement's resource for restrictable actions |
| CKV_AWS_356 | `aws_iam_policy_document` | Ensure no IAM policies documents allow "*" as a statement's resource for restrictable actions |
| CKV_AWS_358 | `aws_iam_policy_document` | Ensure AWS GitHub Actions OIDC authorization policies only allow safe claims and claim order |
| CKV_AWS_359 | `aws_neptune_cluster` | Neptune DB clusters should have IAM database authentication enabled |
| CKV_AWS_366 | `aws_cognito_identity_pool` | Ensure AWS Cognito identity pool does not allow unauthenticated guest access |
| CKV_AWS_40 | `aws_iam_policy_attachment` | Ensure IAM policies are attached only to groups or roles (Reducing access management complexity may in-turn reduce opportunity for a principal to inadvertently receive or retain excessive privileges.) |
| CKV_AWS_41 | `aws` | Ensure no hard coded AWS access key and secret key exists in provider |
| CKV_AWS_49 | `aws_iam_policy_document` | Ensure no IAM policies documents allow "*" as a statement's actions |
| CKV_AWS_60 | `aws_iam_role` | Ensure IAM role allows only specific services or principals to assume it |
| CKV_AWS_61 | `aws_iam_role` | Ensure AWS IAM policy does not allow assume role permission across all services |
| CKV_AWS_62 | `aws_iam_group_policy` | Ensure IAM policies that allow full "*-*" administrative privileges are not created |
| CKV_AWS_63 | `aws_iam_group_policy` | Ensure no IAM policies documents allow "*" as a statement's actions |
| CKV_AWS_9 | `aws_iam_account_password_policy` | Ensure IAM password policy expires passwords within 90 days or less |
