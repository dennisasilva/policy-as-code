# Catálogo built-in — épico `incident-response`

Regras built-in do Checkov (AWS/Terraform) classificadas neste épico: **17**.
Gerado automaticamente por `scripts/generate-catalog.sh`. A lista **aplicada**
pelo gate é `checks.txt` (curada); este catálogo é referência.

| Check ID | Recurso | O que valida |
|---|---|---|
| CKV_AWS_124 | `aws_cloudformation_stack` | Ensure that CloudFormation stacks are sending event notifications to an SNS topic |
| CKV_AWS_133 | `aws_db_instance` | Ensure that RDS instances has backup policy |
| CKV_AWS_134 | `aws_elasticache_cluster` | Ensure that Amazon ElastiCache Redis clusters have automatic backup turned on |
| CKV_AWS_165 | `aws_dynamodb_global_table` | Ensure DynamoDB point in time recovery (backup) is enabled for global tables |
| CKV_AWS_166 | `aws_backup_vault` | Ensure Backup Vault is encrypted at rest using KMS CMK |
| CKV_AWS_168 | `aws_sqs_queue_policy` | Ensure SQS queue policy is not public by only allowing specific services or principals to access it |
| CKV_AWS_169 | `aws_sns_topic_policy` | Ensure SNS topic policy is not public by only allowing specific services or principals to access it |
| CKV_AWS_245 | `aws_db_instance_automated_backups_replication` | Ensure replicated backups are encrypted at rest using KMS CMKs |
| CKV_AWS_26 | `aws_sns_topic` | Ensure all data stored in the SNS topic is encrypted |
| CKV_AWS_27 | `aws_sqs_queue` | Ensure all data stored in the SQS queue is encrypted |
| CKV_AWS_28 | `aws_dynamodb_table` | Ensure DynamoDB point in time recovery (backup) is enabled |
| CKV_AWS_319 | `aws_cloudwatch_metric_alarm` | Ensure that CloudWatch alarm actions are enabled |
| CKV_AWS_360 | `aws_docdb_cluster` | Ensure DocumentDB has an adequate backup retention period |
| CKV_AWS_361 | `aws_neptune_cluster` | Ensure that Neptune DB cluster has automated backups enabled with adequate retention |
| CKV_AWS_385 | `aws_sns_topic_policy` | Ensure AWS SNS topic policies do not allow cross-account access |
| CKV_AWS_387 | `aws_sqs_queue_policy` | Ensure SQS policy does not allow public access through wildcards |
| CKV_AWS_72 | `aws_sqs_queue_policy` | Ensure SQS policy does not allow ALL (*) actions. |
