{{/* Common microservice labels */}}
{{- define "sitewhere.microservice.service" -}}
type: {{ .Values.microservices.default.service.type | default "LoadBalancer" }}
{{- end -}}
