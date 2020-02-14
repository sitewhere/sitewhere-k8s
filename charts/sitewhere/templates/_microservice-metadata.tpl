{{/* Common microservice metadata */}}
{{- define "sitewhere.microservice.metadata" -}}
namespace: {{ .Release.Name }}
{{- end -}}
