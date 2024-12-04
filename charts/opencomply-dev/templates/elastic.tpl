{{- define "elastic.envs"}}
{{- if eq (.Values.externalOpensearch.enabled | toString) "true" }}
- name: ELASTICSEARCH_ADDRESS
  value: "{{ .Values.externalOpensearch.endpoint }}"
- name: ELASTICSEARCH_ISOPENSEARCH
  value: "true"
- name: ELASTICSEARCH_AWS_REGION
  value: "{{ .Values.externalOpensearch.awsRegion }}"
- name: ELASTICSEARCH_AWSREGION
  value: "{{ .Values.externalOpensearch.awsRegion }}"
- name: ELASTICSEARCH_INGESTION_ENDPOINT
  value: ""
- name: ELASTICSEARCH_ASSUME_ROLE_ARN
  value: "{{ .Values.externalOpensearch.roleArn }}"
{{- else }}
- name: ELASTICSEARCH_ADDRESS
  value: "https://opensearch-cluster-master.{{ .Release.Namespace }}.svc.cluster.local:9200"
- name: ELASTICSEARCH_USERNAME
  value: "admin"
- name: ELASTICSEARCH_PASSWORD
  value: "myStrongPassword@123!"
- name: ELASTICSEARCH_INGESTION_ENDPOINT
  value: ""
- name: ELASTICSEARCH_ISONAKS
  value: "true"
{{- end }}
{{- end }}