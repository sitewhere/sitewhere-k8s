{{/* Generate initContainers */}}
{{- define "sitewhere.infra.imagePullSecrets" -}}
{{- if (and (ne (.Values.infra.image.imagePullSecrets | toString) "-") .Values.infra.image.imagePullSecrets) }}
imagePullSecrets:
  - name: {{ .Values.infra.image.imagePullSecrets }}
{{- end }}
{{- end -}}