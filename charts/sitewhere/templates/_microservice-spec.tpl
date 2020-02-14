{{/* Common microservice labels */}}
{{- define "sitewhere.microservice.spec" -}}
replicas: {{ .Values.microservices.default.replicas | default 1 }}
multitenant: true
{{- end -}}
