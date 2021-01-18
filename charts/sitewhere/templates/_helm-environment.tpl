{{/* Helm environment settings */}}
{{- define "sitewhere.helm.environment" -}}
helm:
  chartName: {{ include "sitewhere.chart" . }}
  releaseName: {{ .Release.Name }}
  releaseService: {{ .Release.Service }}
{{- end -}}
