{{/* Docker environment settings */}}
{{- define "sitewhere.docker.environment" -}}
imageRegistry: {{ .Values.docker.imageRegistry | default "docker.io" }}
imageRepository: {{ .Values.docker.imageRepository | default "sitewhere" }}
imageTag: {{ .Values.docker.imageTag | default "3.0.0" }}
imagePullPolicy: {{ .Values.docker.imagePullPolicy | default "IfNotPresent" }}
{{- end -}}
