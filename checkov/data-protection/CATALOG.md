# Catálogo built-in — épico `data-protection`

Regras built-in do Checkov (AWS/Terraform) classificadas neste épico: **160**.
Gerado automaticamente por `scripts/generate-catalog.sh`. A lista **aplicada**
pelo gate é `checks.txt` (curada); este catálogo é referência.

| Check ID | Recurso | O que valida |
|---|---|---|
| CKV_AWS_101 | `aws_neptune_cluster` | Ensure Neptune logging is enabled |
| CKV_AWS_102 | `aws_neptune_cluster_instance` | Ensure Neptune Cluster instance is not publicly available |
| CKV_AWS_104 | `aws_docdb_cluster_parameter_group` | Ensure DocumentDB has audit logs enabled |
| CKV_AWS_105 | `aws_redshift_parameter_group` | Ensure Redshift uses SSL |
| CKV_AWS_106 | `aws_ebs_encryption_by_default` | Ensure EBS default encryption is enabled |
| CKV_AWS_112 | `aws_ssm_document` | Ensure Session Manager data is encrypted in transit |
| CKV_AWS_113 | `aws_ssm_document` | Ensure Session Manager logs are enabled and encrypted |
| CKV_AWS_118 | `aws_db_instance` | Ensure that enhanced monitoring is enabled for Amazon RDS instances |
| CKV_AWS_119 | `aws_dynamodb_table` | Ensure DynamoDB Tables are encrypted using a KMS Customer Managed CMK |
| CKV_AWS_129 | `aws_db_instance` | Ensure that respective logs of Amazon Relational Database Service (Amazon RDS) are enabled |
| CKV_AWS_136 | `aws_ecr_repository` | Ensure that ECR repositories are encrypted using KMS |
| CKV_AWS_139 | `aws_rds_cluster` | Ensure that RDS clusters have deletion protection enabled |
| CKV_AWS_140 | `aws_rds_global_cluster` | Ensure that RDS global clusters are encrypted |
| CKV_AWS_141 | `aws_redshift_cluster` | Ensured that Redshift cluster allowing version upgrade by default |
| CKV_AWS_142 | `aws_redshift_cluster` | Ensure that Redshift cluster is encrypted by KMS |
| CKV_AWS_143 | `aws_s3_bucket` | Ensure that S3 bucket has lock configuration enabled by default |
| CKV_AWS_146 | `aws_db_cluster_snapshot` | Ensure that RDS database cluster snapshot is encrypted |
| CKV_AWS_147 | `aws_codebuild_project` | Ensure that CodeBuild projects are encrypted using CMK |
| CKV_AWS_149 | `aws_secretsmanager_secret` | Ensure that Secrets Manager secret is encrypted using KMS CMK |
| CKV_AWS_154 | `aws_redshift_cluster` | Ensure Redshift is not deployed outside of a VPC |
| CKV_AWS_155 | `aws_workspaces_workspace` | Ensure that Workspace user volumes are encrypted |
| CKV_AWS_156 | `aws_workspaces_workspace` | Ensure that Workspace root volumes are encrypted |
| CKV_AWS_157 | `aws_db_instance` | Ensure that RDS instances have Multi-AZ enabled |
| CKV_AWS_159 | `aws_athena_workgroup` | Ensure that Athena Workgroup is encrypted |
| CKV_AWS_16 | `aws_db_instance` | Ensure all data stored in the RDS is securely encrypted at rest |
| CKV_AWS_160 | `aws_timestreamwrite_database` | Ensure that Timestream database is encrypted with KMS CMK |
| CKV_AWS_167 | `aws_glacier_vault` | Ensure Glacier Vault access policy is not public by only allowing specific services or principals to access it |
| CKV_AWS_17 | `aws_db_instance` | Ensure all data stored in RDS is not publicly accessible |
| CKV_AWS_170 | `aws_qldb_ledger` | Ensure QLDB ledger permissions mode is set to STANDARD |
| CKV_AWS_171 | `aws_emr_security_configuration` | Ensure EMR Cluster security configuration encryption is using SSE-KMS |
| CKV_AWS_172 | `aws_qldb_ledger` | Ensure QLDB ledger has deletion protection enabled |
| CKV_AWS_173 | `aws_lambda_function` | Check encryption settings for Lambda environmental variable |
| CKV_AWS_177 | `aws_kinesis_video_stream` | Ensure Kinesis Video Stream is encrypted by KMS using a customer managed Key (CMK) |
| CKV_AWS_178 | `aws_fsx_ontap_file_system` | Ensure fx ontap file system is encrypted by KMS using a customer managed Key (CMK) |
| CKV_AWS_179 | `aws_fsx_windows_file_system` | Ensure FSX Windows filesystem is encrypted by KMS using a customer managed Key (CMK) |
| CKV_AWS_180 | `aws_imagebuilder_component` | Ensure Image Builder component is encrypted by KMS using a customer managed Key (CMK) |
| CKV_AWS_181 | `aws_s3_object_copy` | Ensure S3 Object Copy is encrypted by KMS using a customer managed Key (CMK) |
| CKV_AWS_182 | `aws_docdb_cluster` | Ensure DocumentDB is encrypted by KMS using a customer managed Key (CMK) |
| CKV_AWS_183 | `aws_ebs_snapshot_copy` | Ensure EBS Snapshot Copy is encrypted by KMS using a customer managed Key (CMK) |
| CKV_AWS_184 | `aws_efs_file_system` | Ensure resource is encrypted by KMS using a customer managed Key (CMK) |
| CKV_AWS_185 | `aws_kinesis_stream` | Ensure Kinesis Stream is encrypted by KMS using a customer managed Key (CMK) |
| CKV_AWS_186 | `aws_s3_bucket_object` | Ensure S3 bucket Object is encrypted by KMS using a customer managed Key (CMK) |
| CKV_AWS_187 | `aws_sagemaker_domain` | Ensure Sagemaker domain and notebook instance are encrypted by KMS using a customer managed Key (CMK) |
| CKV_AWS_189 | `aws_ebs_volume` | Ensure EBS Volume is encrypted by KMS using a customer managed Key (CMK) |
| CKV_AWS_190 | `aws_fsx_lustre_file_system` | Ensure lustre file systems is encrypted by KMS using a customer managed Key (CMK) |
| CKV_AWS_191 | `aws_elasticache_replication_group` | Ensure ElastiCache replication group is encrypted by KMS using a customer managed Key (CMK) |
| CKV_AWS_196 | `aws_elasticache_security_group` | Ensure no aws_elasticache_security_group resources exist |
| CKV_AWS_199 | `aws_imagebuilder_distribution_configuration` | Ensure Image Builder Distribution Configuration encrypts AMI's using KMS - a customer managed Key (CMK) |
| CKV_AWS_200 | `aws_imagebuilder_image_recipe` | Ensure that Image Recipe EBS Disk are encrypted with CMK |
| CKV_AWS_201 | `aws_memorydb_cluster` | Ensure MemoryDB is encrypted at rest using KMS CMKs |
| CKV_AWS_202 | `aws_memorydb_cluster` | Ensure MemoryDB data is encrypted in transit |
| CKV_AWS_203 | `aws_fsx_openzfs_file_system` | Ensure resource is encrypted by KMS using a customer managed Key (CMK) |
| CKV_AWS_204 | `aws_ami` | Ensure AMIs are encrypted using KMS CMKs |
| CKV_AWS_209 | `aws_mq_broker` | Ensure MQ broker encrypted by KMS using a customer managed Key (CMK) |
| CKV_AWS_211 | `aws_db_instance` | Ensure RDS uses a modern CaCert |
| CKV_AWS_212 | `aws_dms_replication_instance` | Ensure DMS replication instance is encrypted by KMS using a customer managed Key (CMK) |
| CKV_AWS_214 | `aws_appsync_api_cache` | Ensure AppSync API Cache is encrypted at rest |
| CKV_AWS_215 | `aws_appsync_api_cache` | Ensure AppSync API Cache is encrypted in transit |
| CKV_AWS_219 | `aws_codepipeline` | Ensure CodePipeline Artifact store is using a KMS CMK |
| CKV_AWS_22 | `aws_sagemaker_notebook_instance` | Ensure SageMaker Notebook is encrypted at rest using KMS CMK |
| CKV_AWS_221 | `aws_codeartifact_domain` | Ensure CodeArtifact Domain is encrypted by KMS using a customer managed Key (CMK) |
| CKV_AWS_226 | `aws_db_instance` | Ensure DB instance gets all minor upgrades automatically |
| CKV_AWS_227 | `aws_kms_key` | Ensure KMS key is enabled |
| CKV_AWS_23 | `aws_elasticache_security_group` | Ensure every security group and rule has a description |
| CKV_AWS_235 | `aws_ami_copy` | Ensure that copied AMIs are encrypted |
| CKV_AWS_239 | `aws_dax_cluster` | Ensure DAX cluster endpoint is using TLS |
| CKV_AWS_240 | `aws_kinesis_firehose_delivery_stream` | Ensure Kinesis Firehose delivery stream is encrypted |
| CKV_AWS_241 | `aws_kinesis_firehose_delivery_stream` | Ensure that Kinesis Firehose Delivery Streams are encrypted with CMK |
| CKV_AWS_246 | `aws_rds_cluster_activity_stream` | Ensure RDS Cluster activity streams are encrypted using KMS CMKs |
| CKV_AWS_247 | `aws_elasticsearch_domain` | Ensure all data stored in the Elasticsearch is encrypted with a CMK |
| CKV_AWS_250 | `aws_db_instance` | Ensure that RDS PostgreSQL instances use a non vulnerable version with the log_fdw extension (https://aws.amazon.com/security/security-bulletins/AWS-2022-004/) |
| CKV_AWS_253 | `aws_dlm_lifecycle_policy` | Ensure DLM cross region events are encrypted |
| CKV_AWS_254 | `aws_dlm_lifecycle_policy` | Ensure DLM cross region events are encrypted with Customer Managed Key |
| CKV_AWS_255 | `aws_dlm_lifecycle_policy` | Ensure DLM cross region schedules are encrypted |
| CKV_AWS_256 | `aws_dlm_lifecycle_policy` | Ensure DLM cross region schedules are encrypted using a Customer Managed Key |
| CKV_AWS_262 | `aws_kendra_index` | Ensure Kendra index Server side encryption uses CMK |
| CKV_AWS_267 | `aws_comprehend_entity_recognizer` | Ensure that Comprehend Entity Recognizer's model is encrypted by KMS using a customer managed Key (CMK) |
| CKV_AWS_268 | `aws_comprehend_entity_recognizer` | Ensure that Comprehend Entity Recognizer's volume is encrypted by KMS using a customer managed Key (CMK) |
| CKV_AWS_271 | `aws_dynamodb_table_replica` | Ensure DynamoDB table replica KMS encryption uses CMK |
| CKV_AWS_278 | `aws_memorydb_snapshot` | Ensure MemoryDB snapshot is encrypted by KMS using a customer managed Key (CMK) |
| CKV_AWS_279 | `aws_neptune_cluster_snapshot` | Ensure Neptune snapshot is securely encrypted |
| CKV_AWS_280 | `aws_neptune_cluster_snapshot` | Ensure Neptune snapshot is encrypted by KMS using a customer managed Key (CMK) |
| CKV_AWS_281 | `aws_redshift_snapshot_copy_grant` | Ensure RedShift snapshot copy is encrypted by KMS using a customer managed Key (CMK) |
| CKV_AWS_282 | `aws_redshiftserverless_namespace` | Ensure that Redshift Serverless namespace is encrypted by KMS using a customer managed key (CMK) |
| CKV_AWS_29 | `aws_elasticache_replication_group` | Ensure all data stored in the ElastiCache Replication Group is securely encrypted at rest |
| CKV_AWS_292 | `aws_docdb_global_cluster` | Ensure DocumentDB Global Cluster is encrypted at rest (default is unencrypted) |
| CKV_AWS_293 | `aws_db_instance` | Ensure that AWS database instances have deletion protection enabled |
| CKV_AWS_296 | `aws_dms_endpoint` | Ensure DMS endpoint uses Customer Managed Key (CMK) |
| CKV_AWS_297 | `aws_scheduler_schedule` | Ensure EventBridge Scheduler Schedule uses Customer Managed Key (CMK) |
| CKV_AWS_298 | `aws_dms_s3_endpoint` | Ensure DMS S3 uses Customer Managed Key (CMK) |
| CKV_AWS_3 | `aws_ebs_volume` | Ensure all data stored in the EBS is securely encrypted |
| CKV_AWS_30 | `aws_elasticache_replication_group` | Ensure all data stored in the ElastiCache Replication Group is securely encrypted at transit |
| CKV_AWS_300 | `aws_s3_bucket_lifecycle_configuration` | Ensure S3 lifecycle configuration sets period for aborting failed uploads |
| CKV_AWS_304 | `aws_secretsmanager_secret_rotation` | Ensure Secrets Manager secrets should be rotated within 90 days |
| CKV_AWS_308 | `aws_api_gateway_method_settings` | Ensure API Gateway method setting caching is set to encrypted |
| CKV_AWS_31 | `aws_elasticache_replication_group` | Ensure all data stored in the ElastiCache Replication Group is securely encrypted at transit and has auth token |
| CKV_AWS_311 | `aws_codebuild_project` | Ensure that CodeBuild S3 logs are encrypted |
| CKV_AWS_313 | `aws_rds_cluster` | Ensure RDS cluster configured to copy tags to snapshots |
| CKV_AWS_320 | `aws_redshift_cluster` | Ensure Redshift clusters do not use the default database name |
| CKV_AWS_321 | `aws_redshift_cluster` | Ensure Redshift clusters use enhanced VPC routing |
| CKV_AWS_322 | `aws_elasticache_cluster` | Ensure ElastiCache for Redis cache clusters have auto minor version upgrades enabled |
| CKV_AWS_323 | `aws_elasticache_cluster` | Ensure ElastiCache clusters do not use the default subnet group |
| CKV_AWS_324 | `aws_rds_cluster` | Ensure that RDS Cluster log capture is enabled |
| CKV_AWS_325 | `aws_rds_cluster` | Ensure that RDS Cluster audit logging is enabled for MySQL engine |
| CKV_AWS_326 | `aws_rds_cluster` | Ensure that RDS Aurora Clusters have backtracking enabled |
| CKV_AWS_327 | `aws_rds_cluster` | Ensure RDS Clusters are encrypted using KMS CMKs |
| CKV_AWS_329 | `aws_efs_access_point` | EFS access points should enforce a root directory |
| CKV_AWS_33 | `aws_kms_key` | Ensure KMS key policy does not contain wildcard (*) principal |
| CKV_AWS_330 | `aws_efs_access_point` | EFS access points should enforce a user identity |
| CKV_AWS_337 | `aws_ssm_parameter` | Ensure SSM parameters are using KMS CMK |
| CKV_AWS_343 | `aws_redshift_cluster` | Ensure Amazon Redshift clusters should have automatic snapshots enabled |
| CKV_AWS_345 | `aws_networkfirewall_firewall` | Ensure that Network firewall encryption is via a CMK |
| CKV_AWS_346 | `aws_networkfirewall_firewall_policy` | Ensure Network Firewall Policy defines an encryption configuration that uses a customer managed Key (CMK) |
| CKV_AWS_347 | `aws_neptune_cluster` | Ensure Neptune is encrypted by KMS using a customer managed Key (CMK) |
| CKV_AWS_349 | `aws_emr_security_configuration` | Ensure EMR Cluster security configuration encrypts local disks |
| CKV_AWS_350 | `aws_emr_security_configuration` | Ensure EMR Cluster security configuration encrypts EBS disks |
| CKV_AWS_351 | `aws_emr_security_configuration` | Ensure EMR Cluster security configuration encrypts InTransit |
| CKV_AWS_353 | `aws_db_instance` | Ensure that RDS instances have performance insights enabled |
| CKV_AWS_354 | `aws_db_instance` | Ensure RDS Performance Insights are encrypted using KMS CMKs |
| CKV_AWS_362 | `aws_neptune_cluster` | Neptune DB clusters should be configured to copy tags to snapshots |
| CKV_AWS_367 | `aws_sagemaker_data_quality_job_definition` | Ensure Amazon Sagemaker Data Quality Job uses KMS to encrypt model artifacts |
| CKV_AWS_368 | `aws_sagemaker_data_quality_job_definition` | Ensure Amazon Sagemaker Data Quality Job uses KMS to encrypt data on attached storage volume |
| CKV_AWS_369 | `aws_sagemaker_data_quality_job_definition` | Ensure Amazon Sagemaker Data Quality Job encrypts all communications between instances used for monitoring jobs |
| CKV_AWS_372 | `aws_sagemaker_flow_definition` | Ensure Amazon SageMaker Flow Definition uses KMS for output configurations |
| CKV_AWS_373 | `aws_bedrockagent_agent` | Ensure Bedrock Agent is encrypted with a CMK |
| CKV_AWS_375 | `aws_s3_bucket_acl` | Ensure AWS S3 bucket does not have global view ACL permissions enabled |
| CKV_AWS_379 | `aws_s3_bucket_acl` | Ensure AWS S3 bucket is configured with secure data transport policy |
| CKV_AWS_388 | `aws_db_instance` | Ensure AWS Aurora PostgreSQL is not exposed to local file read vulnerability |
| CKV_AWS_391 | `aws_redshift_cluster` | Avoid AWS Redshift cluster with commonly used master username and public access setting enabled |
| CKV_AWS_392 | `aws_s3_access_point` | Ensure AWS S3 access point block public access setting is enabled |
| CKV_AWS_42 | `aws_efs_file_system` | Ensure EFS is securely encrypted |
| CKV_AWS_43 | `aws_kinesis_stream` | Ensure Kinesis Stream is securely encrypted |
| CKV_AWS_44 | `aws_neptune_cluster` | Ensure Neptune storage is securely encrypted |
| CKV_AWS_47 | `aws_dax_cluster` | Ensure DAX is encrypted at rest (default is unencrypted) |
| CKV_AWS_5 | `aws_elasticsearch_domain` | Ensure all data stored in the Elasticsearch is securely encrypted at rest |
| CKV_AWS_53 | `aws_s3_bucket_public_access_block` | Ensure S3 bucket has block public ACLS enabled |
| CKV_AWS_54 | `aws_s3_bucket_public_access_block` | Ensure S3 bucket has block public policy enabled |
| CKV_AWS_55 | `aws_s3_bucket_public_access_block` | Ensure S3 bucket has ignore public ACLs enabled |
| CKV_AWS_56 | `aws_s3_bucket_public_access_block` | Ensure S3 bucket has 'restrict_public_buckets' enabled |
| CKV_AWS_58 | `aws_eks_cluster` | Ensure EKS Cluster has Secrets Encryption Enabled |
| CKV_AWS_6 | `aws_elasticsearch_domain` | Ensure all Elasticsearch has node-to-node encryption enabled |
| CKV_AWS_64 | `aws_redshift_cluster` | Ensure all data stored in the Redshift cluster is securely encrypted at rest |
| CKV_AWS_7 | `aws_kms_key` | Ensure rotation for customer created CMKs is enabled |
| CKV_AWS_70 | `aws_s3_bucket_policy` | Ensure S3 bucket does not allow an action with any Principal |
| CKV_AWS_71 | `aws_redshift_cluster` | Ensure Redshift Cluster logging is enabled |
| CKV_AWS_74 | `aws_docdb_cluster` | Ensure DocumentDB is encrypted at rest (default is unencrypted) |
| CKV_AWS_77 | `aws_athena_database` | Ensure Athena Database is encrypted at rest (default is unencrypted) |
| CKV_AWS_78 | `aws_codebuild_project` | Ensure that CodeBuild Project encryption is not disabled |
| CKV_AWS_8 | `aws_instance` | Ensure all data stored in the Launch configuration or instance Elastic Blocks Store is securely encrypted |
| CKV_AWS_81 | `aws_msk_cluster` | Ensure MSK Cluster encryption in rest and transit is enabled |
| CKV_AWS_82 | `aws_athena_workgroup` | Ensure Athena Workgroup should enforce configuration to prevent client disabling encryption |
| CKV_AWS_85 | `aws_docdb_cluster` | Ensure DocumentDB Logging is enabled |
| CKV_AWS_87 | `aws_redshift_cluster` | Redshift cluster should not be publicly accessible |
| CKV_AWS_90 | `aws_docdb_cluster_parameter_group` | Ensure DocumentDB TLS is not disabled |
| CKV_AWS_93 | `aws_s3_bucket_policy` | Ensure S3 bucket policy does not lockout all but root user. (Prevent lockouts needing root account fixes) |
| CKV_AWS_94 | `aws_glue_data_catalog_encryption_settings` | Ensure Glue Data Catalog Encryption is enabled |
| CKV_AWS_96 | `aws_rds_cluster` | Ensure all data stored in Aurora is securely encrypted at rest |
| CKV_AWS_97 | `aws_ecs_task_definition` | Ensure Encryption in transit is enabled for EFS volumes in ECS Task definitions |
| CKV_AWS_98 | `aws_sagemaker_endpoint_configuration` | Ensure all data stored in the Sagemaker Endpoint is securely encrypted at rest |
| CKV_AWS_99 | `aws_glue_security_configuration` | Ensure Glue Security Configuration Encryption is enabled |
