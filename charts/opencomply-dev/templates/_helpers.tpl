{{- define "dex.postgresHost" -}}
{{- if .Values.externalPostgresql.enabled -}}
{{ .Values.externalPostgresql.endpoint }}
{{- else -}}
{{- include "postgres.endpoint" . -}}
{{- end -}}
{{- end -}}

{{- define "dex.postgresPort" -}}
{{- if .Values.externalPostgresql.enabled -}}
{{ .Values.externalPostgresql.port }}
{{- else -}}
{{- include "postgres.port" . -}}
{{- end -}}
{{- end -}}

{{/*
Update the config file to replcae all occurances of DOMAIN_NAME_PLACEHOLDER_DO_NOT_CHANGE with .Values.global.domain
*/}}
{{- define "dex.config" -}}
{{- $config := .Values.dex.config | toYaml | replace "DOMAIN_NAME_PLACEHOLDER_DO_NOT_CHANGE" .Values.global.domain }}
{{- default $config "" }}
{{- end }}
