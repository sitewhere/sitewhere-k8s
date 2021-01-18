{{/* Common microservice metadata */}}
{{- define "sitewhere.microservice.metadata" -}}
namespace: {{ .Release.Namespace }}
{{- end -}}
