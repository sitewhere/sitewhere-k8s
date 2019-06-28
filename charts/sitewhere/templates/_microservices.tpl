{{/* Generate Container Rediness and Liveness Probes */}}
{{- define "sitewhere.microservice.probes" -}}
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

{{/* Generate Container Resources */}}
{{- define "sitewhere.microservice.resources" -}}
resources:
  limits:
    memory: {{ .Values.resources.limits.memory | default .Defaults.resources.limits.memory | quote }} 
    cpu: {{ .Values.resources.limits.cpu | default .Defaults.resources.limits.cpu | quote }}
  requests:
    memory: {{ .Values.resources.requests.memory | default .Defaults.resources.requests.memory | quote }}
    cpu: {{ .Values.resources.requests.cpu | default .Defaults.resources.requests.cpu | quote }}
{{- end -}}

{{/* Generate Image Pull Secrets */}}
{{- define "sitewhere.microservice.imagePullSecrets" -}}
{{- if (and (ne (.Values.services.image.imagePullSecrets | toString) "-") .Values.services.image.imagePullSecrets) -}}
imagePullSecrets:
  - name: {{ .Values.services.image.imagePullSecrets }}
{{- end -}}
{{- end -}}

{{/* Generate Container Image */}}
{{- define "sitewhere.microservice.image" -}}
{{- if .Defaults.debug }}
image: "{{ .Defaults.image.registry }}/{{ .Defaults.image.repository }}/{{ .Values.image }}:debug-{{ .Defaults.image.tag }}"
{{- else }}
image: "{{ .Defaults.image.registry }}/{{ .Defaults.image.repository }}/{{ .Values.image }}:{{ .Defaults.image.tag }}"
{{- end }} 
{{- end -}}
