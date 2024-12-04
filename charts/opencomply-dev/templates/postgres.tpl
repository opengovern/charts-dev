{{- define "postgres.endpoint" -}}
{{- if .Values.externalPostgresql.enabled }}
{{- printf .Values.externalPostgresql.endpoint }}
{{- else }}
{{- printf "%s-postgresql-primary.%s.svc.cluster.local" .Release.Name .Release.Namespace }}
{{- end }}
{{- end }}

{{- define "postgres.port" -}}
{{- if .Values.externalPostgresql.enabled }}
{{- printf .Values.externalPostgresql.port }}
{{- else }}
{{- printf "5432" }}
{{- end }}
{{- end }}

{{- define "postgres.masterUser" -}}
{{- if .Values.externalPostgresql.enabled }}
{{- printf .Values.externalPostgresql.masterUser }}
{{- else }}
{{- printf "postgres" }}
{{- end }}
{{- end }}

{{- define "postgres.masterPassword" -}}
{{- if .Values.externalPostgresql.enabled }}
{{- printf .Values.externalPostgresql.masterPassword }}
{{- else }}
{{- printf .Values.postgresql.global.postgresql.auth.postgresPassword }}
{{- end }}
{{- end }}

{{- define "postgres.sslMode" -}}
{{- if .Values.externalPostgresql.enabled }}
{{- printf .Values.externalPostgresql.sslMode }}
{{- else }}
{{- printf "disable" }}
{{- end }}
{{- end }}