# Catálogo built-in — épico `infra-security`

Regras built-in do Checkov (AWS/Terraform) classificadas neste épico: **101**.
Gerado automaticamente por `scripts/generate-catalog.sh`. A lista **aplicada**
pelo gate é `checks.txt` (curada); este catálogo é referência.

| Check ID | Recurso | O que valida |
|---|---|---|
| CKV_AWS_100 | `aws_eks_node_group` | Ensure AWS EKS node group does not have implicit SSH access from 0.0.0.0/0 |
| CKV_AWS_115 | `aws_lambda_function` | Ensure that AWS Lambda function is configured for function-level concurrent execution limit |
| CKV_AWS_116 | `aws_lambda_function` | Ensure that AWS Lambda function is configured for a Dead Letter Queue(DLQ) |
| CKV_AWS_117 | `aws_lambda_function` | Ensure that AWS Lambda function is configured inside a VPC |
| CKV_AWS_120 | `aws_api_gateway_stage` | Ensure API Gateway caching is enabled |
| CKV_AWS_123 | `aws_vpc_endpoint_service` | Ensure that VPC Endpoint Service is configured for Manual Acceptance |
| CKV_AWS_126 | `aws_instance` | Ensure that detailed monitoring is enabled for EC2 instances |
| CKV_AWS_127 | `aws_elb` | Ensure that Elastic Load Balancer(s) uses SSL certificates provided by AWS Certificate Manager |
| CKV_AWS_130 | `aws_subnet` | Ensure VPC subnets do not assign public IP by default |
| CKV_AWS_131 | `aws_alb` | Ensure that ALB drops HTTP headers |
| CKV_AWS_135 | `aws_instance` | Ensure that EC2 is EBS optimized |
| CKV_AWS_137 | `aws_elasticsearch_domain` | Ensure that Elasticsearch is configured inside a VPC |
| CKV_AWS_138 | `aws_elb` | Ensure that ELB is cross-zone-load-balancing enabled |
| CKV_AWS_148 | `aws_default_vpc` | Ensure no default VPC is planned to be provisioned |
| CKV_AWS_150 | `aws_alb` | Ensure that Load Balancer has deletion protection enabled |
| CKV_AWS_152 | `aws_alb` | Ensure that Load Balancer (Network/Gateway) has cross-zone load balancing enabled |
| CKV_AWS_164 | `aws_transfer_server` | Ensure Transfer Server is not exposed publicly. |
| CKV_AWS_174 | `aws_cloudfront_distribution` | Verify CloudFront Distribution Viewer Certificate is using TLS v1.2 or higher |
| CKV_AWS_175 | `aws_waf_web_acl` | Ensure WAF has associated rules |
| CKV_AWS_176 | `aws_waf_web_acl` | Ensure Logging is enabled for WAF Web Access Control Lists |
| CKV_AWS_192 | `aws_wafv2_web_acl` | Ensure WAF prevents message lookup in Log4j2. See CVE-2021-44228 aka log4jshell |
| CKV_AWS_195 | `aws_glue_dev_endpoint` | Ensure Glue component has a security configuration associated |
| CKV_AWS_2 | `aws_alb_listener` | Ensure ALB protocol is HTTPS |
| CKV_AWS_206 | `aws_api_gateway_domain_name` | Ensure API Gateway Domain uses a modern security Policy |
| CKV_AWS_216 | `aws_cloudfront_distribution` | Ensure CloudFront distribution is enabled |
| CKV_AWS_217 | `aws_api_gateway_deployment` | Ensure Create before destroy for API deployments |
| CKV_AWS_218 | `aws_cloudsearch_domain` | Ensure that CloudSearch is using latest TLS |
| CKV_AWS_220 | `aws_cloudsearch_domain` | Ensure that CloudSearch is using https |
| CKV_AWS_223 | `aws_ecs_cluster` | Ensure ECS Cluster enables logging of ECS Exec |
| CKV_AWS_224 | `aws_ecs_cluster` | Ensure ECS Cluster logging is enabled and client to container communication uses CMK |
| CKV_AWS_225 | `aws_api_gateway_method_settings` | Ensure API Gateway method setting caching is enabled |
| CKV_AWS_228 | `aws_elasticsearch_domain` | Verify Elasticsearch domain is using an up to date TLS policy |
| CKV_AWS_229 | `aws_network_acl_rule` | Ensure no NACL allow ingress from 0.0.0.0:0 to port 21 |
| CKV_AWS_23 | `aws_db_security_group` | Ensure every security group and rule has a description |
| CKV_AWS_230 | `aws_network_acl_rule` | Ensure no NACL allow ingress from 0.0.0.0:0 to port 20 |
| CKV_AWS_231 | `aws_network_acl_rule` | Ensure no NACL allow ingress from 0.0.0.0:0 to port 3389 |
| CKV_AWS_232 | `aws_network_acl_rule` | Ensure no NACL allow ingress from 0.0.0.0:0 to port 22 |
| CKV_AWS_233 | `aws_acm_certificate` | Ensure Create before destroy for ACM certificates |
| CKV_AWS_234 | `aws_acm_certificate` | Verify logging preference for ACM certificates |
| CKV_AWS_237 | `aws_api_gateway_rest_api` | Ensure Create before destroy for API Gateway |
| CKV_AWS_24 | `aws_security_group_rule` | Ensure no security groups allow ingress from 0.0.0.0:0 to port 22 |
| CKV_AWS_248 | `aws_elasticsearch_domain` | Ensure that Elasticsearch is not using the default Security Group |
| CKV_AWS_249 | `aws_ecs_task_definition` | Ensure that the Execution Role ARN and the Task Role ARN are different in ECS Task definitions |
| CKV_AWS_25 | `aws_security_group_rule` | Ensure no security groups allow ingress from 0.0.0.0:0 to port 3389 |
| CKV_AWS_258 | `aws_lambda_function_url` | Ensure that Lambda function URLs AuthType is not None |
| CKV_AWS_259 | `aws_cloudfront_response_headers_policy` | Ensure CloudFront response header policy enforces Strict Transport Security |
| CKV_AWS_260 | `aws_security_group_rule` | Ensure no security groups allow ingress from 0.0.0.0:0 to port 80 |
| CKV_AWS_261 | `aws_alb_target_group` | Ensure HTTP HTTPS Target group defines Healthcheck |
| CKV_AWS_272 | `aws_lambda_function` | Ensure AWS Lambda function is configured to validate code-signing |
| CKV_AWS_276 | `aws_api_gateway_method_settings` | Ensure Data Trace is not enabled in API Gateway Method Settings |
| CKV_AWS_277 | `aws_security_group_rule` | Ensure no security groups allow ingress from 0.0.0.0:0 to port -1 |
| CKV_AWS_301 | `aws_lambda_permission` | Ensure that AWS Lambda function is not publicly accessible |
| CKV_AWS_302 | `aws_db_snapshot` | Ensure DB Snapshots are not Public |
| CKV_AWS_303 | `aws_ssm_document` | Ensure SSM documents are not Public |
| CKV_AWS_305 | `aws_cloudfront_distribution` | Ensure CloudFront distribution has a default root object configured |
| CKV_AWS_309 | `aws_apigatewayv2_route` | Ensure API GatewayV2 routes specify an authorization type |
| CKV_AWS_310 | `aws_cloudfront_distribution` | Ensure CloudFront distributions should have origin failover configured |
| CKV_AWS_317 | `aws_elasticsearch_domain` | Ensure Elasticsearch Domain Audit Logging is enabled |
| CKV_AWS_318 | `aws_elasticsearch_domain` | Ensure Elasticsearch domains are configured with at least three dedicated master nodes for HA |
| CKV_AWS_32 | `aws_ecr_repository_policy` | Ensure ECR policy is not set to public |
| CKV_AWS_328 | `aws_alb` | Ensure that ALB is configured with defensive or strictest desync mitigation mode |
| CKV_AWS_331 | `aws_ec2_transit_gateway` | Ensure Transit Gateways do not automatically accept VPC attachment requests |
| CKV_AWS_332 | `aws_ecs_service` | Ensure ECS Fargate services run on the latest Fargate platform version |
| CKV_AWS_333 | `aws_ecs_service` | Ensure ECS services do not have public IP addresses assigned to them automatically |
| CKV_AWS_334 | `aws_ecs_task_definition` | Ensure ECS containers should run as non-privileged |
| CKV_AWS_335 | `aws_ecs_task_definition` | Ensure ECS task definitions should not share the host's process namespace |
| CKV_AWS_336 | `aws_ecs_task_definition` | Ensure ECS containers are limited to read-only access to root filesystems |
| CKV_AWS_339 | `aws_eks_cluster` | Ensure EKS clusters run on a supported Kubernetes version |
| CKV_AWS_34 | `aws_cloudfront_distribution` | Ensure CloudFront distribution ViewerProtocolPolicy is set to HTTPS |
| CKV_AWS_342 | `aws_waf_rule_group` | Ensure WAF rule has any actions |
| CKV_AWS_344 | `aws_networkfirewall_firewall` | Ensure that Network firewalls have deletion protection enabled |
| CKV_AWS_352 | `aws_network_acl_rule` | Ensure NACL ingress does not allow all Ports |
| CKV_AWS_363 | `aws_lambda_function` | Ensure Lambda Runtime is not deprecated |
| CKV_AWS_364 | `aws_lambda_permission` | Ensure that AWS Lambda function permissions delegated to AWS services are limited by SourceArn or SourceAccount |
| CKV_AWS_365 | `aws_ses_configuration_set` | Ensure SES Configuration Set enforces TLS usage |
| CKV_AWS_37 | `aws_eks_cluster` | Ensure Amazon EKS control plane logging is enabled for all log types |
| CKV_AWS_374 | `aws_cloudfront_distribution` | Ensure AWS CloudFront web distribution has geo restriction enabled |
| CKV_AWS_376 | `aws_elb` | Ensure AWS Elastic Load Balancer listener uses TLS/SSL |
| CKV_AWS_38 | `aws_eks_cluster` | Ensure Amazon EKS public endpoint not accessible to 0.0.0.0/0 |
| CKV_AWS_382 | `aws_security_group_rule` | Ensure no security groups allow egress from 0.0.0.0:0 to port -1 |
| CKV_AWS_389 | `aws_launch_configuration` | Ensure AWS Auto Scaling group launch configuration doesn't have public IP address assignment enabled |
| CKV_AWS_39 | `aws_eks_cluster` | Ensure Amazon EKS public endpoint disabled |
| CKV_AWS_390 | `aws_emr_block_public_access_configuration` | Ensure AWS EMR block public access setting is enabled |
| CKV_AWS_45 | `aws_lambda_function` | Ensure no hard-coded secrets exist in lambda environment |
| CKV_AWS_46 | `aws_instance` | Ensure no hard-coded secrets exist in EC2 user data |
| CKV_AWS_50 | `aws_lambda_function` | X-Ray tracing is enabled for Lambda |
| CKV_AWS_59 | `aws_api_gateway_method` | Ensure there is no open access to back-end resources through API |
| CKV_AWS_65 | `aws_ecs_cluster` | Ensure container insights are enabled on ECS cluster |
| CKV_AWS_68 | `aws_cloudfront_distribution` | CloudFront Distribution should have WAF enabled |
| CKV_AWS_69 | `aws_mq_broker` | Ensure MQ Broker is not publicly exposed |
| CKV_AWS_73 | `aws_api_gateway_stage` | Ensure API Gateway has X-Ray Tracing enabled |
| CKV_AWS_76 | `aws_api_gateway_stage` | Ensure API Gateway has Access Logging enabled |
| CKV_AWS_79 | `aws_instance` | Ensure Instance Metadata Service Version 1 is not enabled |
| CKV_AWS_83 | `aws_elasticsearch_domain` | Ensure Elasticsearch Domain enforces HTTPS |
| CKV_AWS_84 | `aws_elasticsearch_domain` | Ensure Elasticsearch Domain Logging is enabled |
| CKV_AWS_86 | `aws_cloudfront_distribution` | Ensure CloudFront distribution has Access Logging enabled |
| CKV_AWS_88 | `aws_instance` | EC2 instance should not have public IP. |
| CKV_AWS_89 | `aws_dms_replication_instance` | DMS replication instance should not be publicly accessible |
| CKV_AWS_91 | `aws_alb` | Ensure the ELBv2 (Application/Network) has access logging enabled |
| CKV_AWS_92 | `aws_elb` | Ensure the ELB has access logging enabled |
| CKV2_AWS_70 | `aws_api_gateway_method` | Ensure API gateway method has authorization or API key set |
