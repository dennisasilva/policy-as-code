# Catálogo built-in — épico `detective-controls`

Regras built-in do Checkov (AWS/Terraform) classificadas neste épico: **12**.
Gerado automaticamente por `scripts/generate-catalog.sh`. A lista **aplicada**
pelo gate é `checks.txt` (curada); este catálogo é referência.

| Check ID | Recurso | O que valida |
|---|---|---|
| CKV_AWS_121 | `aws_config_configuration_aggregator` | Ensure AWS Config is enabled in all regions |
| CKV_AWS_158 | `aws_cloudwatch_log_group` | Ensure that CloudWatch Log Group is encrypted by KMS |
| CKV_AWS_238 | `aws_guardduty_detector` | Ensure that GuardDuty detector is enabled |
| CKV_AWS_251 | `aws_cloudtrail` | Ensure CloudTrail logging is enabled |
| CKV_AWS_252 | `aws_cloudtrail` | Ensure CloudTrail defines an SNS Topic |
| CKV_AWS_294 | `aws_cloudtrail_event_data_store` | Ensure CloudTrail Event Data Store uses CMK |
| CKV_AWS_338 | `aws_cloudwatch_log_group` | Ensure CloudWatch log groups retains logs for at least 1 year |
| CKV_AWS_35 | `aws_cloudtrail` | Ensure CloudTrail logs are encrypted at rest using KMS CMKs |
| CKV_AWS_36 | `aws_cloudtrail` | Ensure CloudTrail log file validation is enabled |
| CKV_AWS_66 | `aws_cloudwatch_log_group` | Ensure that CloudWatch Log Group specifies retention days |
| CKV_AWS_67 | `aws_cloudtrail` | Ensure CloudTrail is enabled in all Regions |
| CKV_AWS_75 | `aws_globalaccelerator_accelerator` | Ensure Global Accelerator accelerator has flow logs enabled |
