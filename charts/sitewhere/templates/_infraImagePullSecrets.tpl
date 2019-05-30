{{/* Generate Generate Image Pull Secrets */}}
{{- define "sitewhere.infra.imagePullSecrets" -}}
{{- if (and (ne (.Values.infra.image.imagePullSecrets | toString) "-") .Values.infra.image.imagePullSecrets) }}
imagePullSecrets:
  - name: {{ .Values.infra.image.imagePullSecrets }}
{{- end }}
{{- end -}}