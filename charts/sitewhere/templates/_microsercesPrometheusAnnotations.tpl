{{/* Generate Microservice Annotations  */}}
{{- define "sitewhere.microservice.prometheus" -}}
prometheus.io/scrape: "true"
prometheus.io/path: {{ .Values.services.metrics.path | quote }}
prometheus.io/port: {{ .Values.services.metrics.port | quote }}
{{- end -}}