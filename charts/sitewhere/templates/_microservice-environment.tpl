{{/* Common microservice environment variables */}}
{{- define "sitewhere.microservice.environment" -}}
- name: "sitewhere.config.k8s.name"
  valueFrom:
    fieldRef:
      fieldPath: metadata.name
- name: "sitewhere.config.k8s.namespace"
  valueFrom:
    fieldRef:
      fieldPath: metadata.namespace
- name: "sitewhere.config.k8s.pod.ip"
  valueFrom:
    fieldRef:
      fieldPath: status.podIP
{{- end -}}
