{{/* Generate Microservice Annotations  */}}
{{- define "sitewhere.microservice.prometheus" -}}
prometheus.io/scrape: "true"
prometheus.io/scheme: "http"
prometheus.io/port: {{ .Values.services.metrics.port | quote }}
{{- end -}}