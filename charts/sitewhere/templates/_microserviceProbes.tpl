{{- define "sitewhere.microserviceProbes" -}}
readinessProbe:
  exec:
    command: ["/bin/grpc_health_probe", "-addr=:{{ .Values.services.health.port }}"]
  initialDelaySeconds: {{ .Values.services.health.readinessProbe.initialDelay }}
livenessProbe:
  exec:
    command: ["/bin/grpc_health_probe", "-addr=:{{ .Values.services.health.port }}"]
  initialDelaySeconds: {{ .Values.services.health.livenessProbe.initialDelay }}
  periodSeconds: {{ .Values.services.health.livenessProbe.periodSeconds }}
{{- end -}}
