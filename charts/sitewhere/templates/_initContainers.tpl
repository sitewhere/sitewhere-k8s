{{/* Generate initContainers */}}
{{- define "sitewhere.initContainers" }}
{{- if .Values.services.initContainers }}
initContainers:
  - name: pod-dependency
    image: ylonkar/pod-dependency-init-container:1.0
    env:
      - name: POD_LABELS
        value: sitewhere.io/role=infrastructure,sitewhere.io/name=mongodb
      - name: MAX_RETRY
        value: "10"
      - name: RETRY_TIME_OUT
        value: "5000"
{{- end }}
{{- end }}