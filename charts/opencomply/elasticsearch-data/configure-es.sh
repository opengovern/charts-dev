#!/bin/sh

set -x

apk update
apk add --no-cache jq curl

HTTP_PROTOCOL="${HTTP_METHOD:-https}"
ES_HOST="${ES_HOST:-localhost}"
ES_PORT="${ES_PORT:-9200}"
ES_USER="${ES_USER:-elastic}"

escurl() {
  METHOD="$1"
  HTTP_PATH="$2"
  BODY="$3"

  curl -X ${METHOD} -u "${ES_USER}:${ES_PASSWORD}" -k "${HTTP_PROTOCOL}://${ES_HOST}:${ES_PORT}/${HTTP_PATH}" -H 'Content-Type: application/json' -d "${BODY}"
}

STATUS=$(escurl GET '_cluster/health?pretty' | jq -r '.status')
COUNTER=0
while [ "$STATUS" != "green"  ] && [ "$STATUS" != "yellow" ] && [ "$COUNTER" -lt 10 ];
do
    echo "Waiting for status to be GREEN or YELLOW. Sleeping for 10 seconds..."
    sleep 10
    STATUS=$(escurl GET '_cluster/health?pretty' | jq -r '.status')
    COUNTER=$((COUNTER+1))
done
if [ "$STATUS" != "green"  ] && [ "$STATUS" != "yellow" ]; then
    echo "Status is still ${STATUS}. Exiting..."
    exit 1
fi

echo "Status is now ${STATUS}. Proceeding..."
sleep 10

escurl PUT '_component_template/resource_component_template' @resource_component_template.json
escurl PUT '_index_template/azure_resource_index_template' @azure_resource_index_template.json
escurl PUT '_index_template/aws_resource_index_template' @aws_resource_index_template.json
escurl PUT '_index_template/aws_iam_policy_index_template' @aws_iam_policy_index_template.json
escurl PUT '_index_template/aws_iam_credentialreport_index_template' @aws_iam_credentialreport_index_template.json
escurl PUT '_index_template/aws_lambda_function_index_template' @aws_lambda_function_index_template.json
escurl PUT '_index_template/aws_lambda_functionversion_index_template' @aws_lambda_functionversion_index_template.json
escurl PUT '_index_template/aws_securityhub_finding_index_template' @aws_securityhub_finding_index_template.json
escurl PUT '_index_template/aws_secretsmanager_secret_index_template' @aws_secretsmanager_secret_index_template.json
escurl PUT '_index_template/aws_glue_catalogtable_index_template' @aws_glue_catalogtable_index_template.json
escurl PUT '_index_template/aws_athena_queryexecution_index_template' @aws_athena_queryexecution_index_template.json
escurl PUT '_index_template/aws_certificatemanager_certificate_index_template' @aws_certificatemanager_certificate_index_template.json
escurl PUT '_index_template/aws_cloudformation_stack_index_template' @aws_cloudformation_stack_index_template.json
escurl PUT '_index_template/aws_ecr_repository_index_template' @aws_ecr_repository_index_template.json
escurl PUT '_index_template/aws_ecs_service_index_template' @aws_ecs_service_index_template.json
escurl PUT '_index_template/aws_ec2_instance_index_template' @aws_ec2_instance_index_template.json
escurl PUT '_index_template/aws_accessanalyzer_analyzer_index_template' @aws_accessanalyzer_analyzer_index_template.json
escurl PUT '_index_template/aws_wafv2_ipset_index_template' @aws_wafv2_ipset_index_template.json
escurl PUT '_index_template/aws_rds_dbclusterparametergroup_index_template' @aws_rds_dbclusterparametergroup_index_template.json
escurl PUT '_index_template/aws_ec2_routetable_index_template' @aws_ec2_routetable_index_template.json
escurl PUT '_index_template/aws_s3_bucket_index_template' @aws_s3_bucket_index_template.json
escurl PUT '_index_template/aws_wafv2_rulegroup_index_template' @aws_wafv2_rulegroup_index_template.json
escurl PUT '_index_template/aws_wafv2_webacl_index_template' @aws_wafv2_webacl_index_template.json
escurl PUT '_index_template/azure_virtualmachine_index_template' @azure_virtualmachine_index_template.json
escurl PUT '_index_template/azure_network_networksecuritygroups_index_template' @azure_network_networksecuritygroups_index_template.json
escurl PUT '_index_template/azure_virtualnetworks_subnets_index_template' @azure_virtualnetworks_subnets_index_template.json
escurl PUT '_index_template/azure_documentdb_sqldatabases_index_template' @azure_documentdb_sqldatabases_index_template.json
escurl PUT '_index_template/azure_network_frontdoors_index_template' @azure_network_frontdoors_index_template.json
escurl PUT '_index_template/azure_logic_workflows_index_template' @azure_logic_workflows_index_template.json
escurl PUT '_index_template/azure_network_loadbalancers_index_template' @azure_network_loadbalancers_index_template.json
escurl PUT '_index_template/azure_network_routetables_index_template' @azure_network_routetables_index_template.json
escurl PUT '_index_template/azure_network_virtualnetworks_index_template' @azure_network_virtualnetworks_index_template.json
escurl PUT '_index_template/azure_compute_virtualmachines_index_template' @azure_compute_virtualmachines_index_template.json
escurl PUT '_index_template/azure_compute_virtualmachinescalesets_index_template' @azure_compute_virtualmachinescalesets_index_template.json
escurl PUT '_index_template/azure_dbformysql_servers_index_template' @azure_dbformysql_servers_index_template.json
escurl PUT '_index_template/azure_dbforpostgresql_servers_index_template' @azure_dbforpostgresql_servers_index_template.json
escurl PUT '_index_template/azure_sql_servers_index_template' @azure_sql_servers_index_template.json
escurl PUT '_index_template/azure_web_plan_index_template' @azure_web_plan_index_template.json
escurl PUT '_index_template/azure_web_sites_index_template' @azure_web_sites_index_template.json
escurl PUT '_index_template/compliance_report_template' @compliance_report_template.json
escurl PUT '_index_template/compliance_summary_template' @compliance_summary_template.json
escurl PUT '_index_template/account_report_template' @account_report_template.json
escurl PUT '_index_template/source_resource_summary_template' @source_resource_summary_template.json
escurl PUT '_index_template/inventory_summary_template' @inventory_summary_template.json
escurl PUT '_index_template/insights_template' @insights_template.json
escurl PUT '_index_template/stack_insights_template' @stack_insights_template.json
escurl PUT '_index_template/connection_summary_template' @connection_summary_template.json
escurl PUT '_index_template/provider_summary_template' @provider_summary_template.json
escurl PUT '_index_template/compliance_result_template' @compliance_result_template.json
escurl PUT '_index_template/compliance_result_event_template' @compliance_result_event_template.json
escurl PUT '_index_template/resource_findings_template' @resource_findings_template.json
escurl PUT '_index_template/stack_findings_template' @stack_findings_template.json
escurl PUT '_index_template/benchmark_summary_template' @benchmark_summary_template.json
escurl PUT '_index_template/cost_summary_template' @cost_summary_template.json