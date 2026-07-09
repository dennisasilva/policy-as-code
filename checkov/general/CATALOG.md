# Catálogo built-in — épico `general`

Regras built-in do Checkov (AWS/Terraform) classificadas neste épico: **51**.
Gerado automaticamente por `scripts/generate-catalog.sh`. A lista **aplicada**
pelo gate é `checks.txt` (curada); este catálogo é referência.

| Check ID | Recurso | O que valida |
|---|---|---|
| CKV_AWS_114 | `aws_emr_cluster` | Ensure that EMR clusters with Kerberos have Kerberos Realm set |
| CKV_AWS_122 | `aws_sagemaker_notebook_instance` | Ensure that direct internet access is disabled for an Amazon SageMaker Notebook Instance |
| CKV_AWS_153 | `aws_autoscaling_group` | Autoscaling groups should supply tags to launch configurations |
| CKV_AWS_163 | `aws_ecr_repository` | Ensure ECR image scanning on push is enabled |
| CKV_AWS_193 | `aws_appsync_graphql_api` | Ensure AppSync has Logging enabled |
| CKV_AWS_194 | `aws_appsync_graphql_api` | Ensure AppSync has Field-Level logs enabled |
| CKV_AWS_195 | `aws_glue_crawler` | Ensure Glue component has a security configuration associated |
| CKV_AWS_197 | `aws_mq_broker` | Ensure MQ Broker Audit logging is enabled |
| CKV_AWS_198 | `aws_db_security_group` | Ensure no aws_db_security_group resources exist |
| CKV_AWS_205 | `aws_ami_launch_permission` | Ensure to Limit AMI launch Permissions |
| CKV_AWS_207 | `aws_mq_broker` | Ensure MQ Broker minor version updates are enabled |
| CKV_AWS_208 | `aws_mq_broker` | Ensure MQ Broker version is current |
| CKV_AWS_210 | `aws_batch_job_definition` | Batch job does not define a privileged container |
| CKV_AWS_213 | `aws_load_balancer_policy` | Ensure ELB Policy uses only secure protocols |
| CKV_AWS_222 | `aws_dms_replication_instance` | Ensure DMS replication instance gets all minor upgrade automatically |
| CKV_AWS_236 | `aws_ami_copy` | Ensure AMI copying uses a CMK |
| CKV_AWS_242 | `aws_mwaa_environment` | Ensure MWAA environment has scheduler logs enabled |
| CKV_AWS_243 | `aws_mwaa_environment` | Ensure MWAA environment has worker logs enabled |
| CKV_AWS_244 | `aws_mwaa_environment` | Ensure MWAA environment has webserver logs enabled |
| CKV_AWS_257 | `aws_codecommit_approval_rule_template` | Ensure CodeCommit branch changes have at least 2 approvals |
| CKV_AWS_263 | `aws_appflow_flow` | Ensure AppFlow flow uses CMK |
| CKV_AWS_264 | `aws_appflow_connector_profile` | Ensure AppFlow connector profile uses CMK |
| CKV_AWS_265 | `aws_keyspaces_table` | Ensure Keyspaces Table uses CMK |
| CKV_AWS_266 | `aws_db_snapshot_copy` | Ensure DB Snapshot copy uses CMK |
| CKV_AWS_269 | `aws_connect_instance_storage_config` | Ensure Connect Instance Kinesis Video Stream Storage Config uses CMK |
| CKV_AWS_270 | `aws_connect_instance_storage_config` | Ensure Connect Instance S3 Storage Config uses CMK |
| CKV_AWS_284 | `aws_sfn_state_machine` | Ensure State Machine has X-Ray tracing enabled |
| CKV_AWS_285 | `aws_sfn_state_machine` | Ensure State Machine has execution history logging enabled |
| CKV_AWS_291 | `aws_msk_cluster` | Ensure MSK nodes are private |
| CKV_AWS_295 | `aws_datasync_location_object_storage` | Ensure DataSync Location Object Storage doesn't expose secrets |
| CKV_AWS_306 | `aws_sagemaker_notebook_instance` | Ensure SageMaker notebook instances should be launched into a custom VPC |
| CKV_AWS_307 | `aws_sagemaker_notebook_instance` | Ensure SageMaker Users should not have root access to SageMaker notebook instances |
| CKV_AWS_312 | `aws_elastic_beanstalk_environment` | Ensure Elastic Beanstalk environments have enhanced health reporting enabled |
| CKV_AWS_314 | `aws_codebuild_project` | Ensure CodeBuild project environments have a logging configuration |
| CKV_AWS_315 | `aws_autoscaling_group` | Ensure EC2 Auto Scaling groups use EC2 launch templates |
| CKV_AWS_316 | `aws_codebuild_project` | Ensure CodeBuild project environments do not have privileged mode enabled |
| CKV_AWS_340 | `aws_elastic_beanstalk_environment` | Ensure Elastic Beanstalk managed platform updates are enabled |
| CKV_AWS_341 | `aws_launch_configuration` | Ensure Launch template should not have a metadata response hop limit greater than 1 |
| CKV_AWS_357 | `aws_transfer_server` | Ensure Transfer Server allows only secure protocols |
| CKV_AWS_370 | `aws_sagemaker_model` | Ensure Amazon SageMaker model uses network isolation |
| CKV_AWS_371 | `aws_sagemaker_notebook_instance` | Ensure Amazon SageMaker Notebook Instance only allows for IMDSv2 |
| CKV_AWS_377 | `aws_route53domains_registered_domain` | Ensure Route 53 domains have transfer lock protection |
| CKV_AWS_380 | `aws_transfer_server` | Ensure AWS Transfer Server uses latest Security Policy |
| CKV_AWS_381 | `aws_codegurureviewer_repository_association` | Make sure that aws_codegurureviewer_repository_association has a CMK |
| CKV_AWS_383 | `aws_bedrockagent_agent` | Ensure AWS Bedrock agent is associated with Bedrock guardrails |
| CKV_AWS_386 | `aws_ami` | Reduce potential for WhoAMI cloud image name confusion attack |
| CKV_AWS_46 | `aws_launch_configuration` | Ensure no hard-coded secrets exist in EC2 user data |
| CKV_AWS_48 | `aws_mq_broker` | Ensure MQ Broker logging is enabled |
| CKV_AWS_51 | `aws_ecr_repository` | Ensure ECR Image Tags are immutable |
| CKV_AWS_79 | `aws_launch_configuration` | Ensure Instance Metadata Service Version 1 is not enabled |
| CKV_AWS_80 | `aws_msk_cluster` | Ensure MSK Cluster logging is enabled |
