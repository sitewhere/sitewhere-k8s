{{/* Common microservice labels */}}
{{- define "sitewhere.microservice.labels" -}}
sitewhere.io/instance: {{ .Release.Name }}
{{- end -}}
