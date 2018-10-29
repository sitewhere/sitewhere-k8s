{{/* Generate initContainers */}}
{{- define "sitewhere.services.imagePullSecrets" }}
{{- if (and (ne (.Values.services.image.imagePullSecrets | toString) "-") .Values.services.image.imagePullSecrets) }}
imagePullSecrets:
  - name: {{ .Values.services.image.imagePullSecrets }}
{{- end }}
{{- end }}