{{/*
SiteWhere Zookeeper Hostname.
*/}}
{{- define "sitewhere.zookeeper.host" -}}
{{- if (index .Values "sitewhere-infra-core" "kafka" "enabled") -}}
{{ include "sitewhere.fullname" . }}-zookeeper
{{- else -}}
{{- index .Values "sitewhere-infra-core" "kafka" "zookeeper_host" -}}
{{- end -}}
{{- end -}}

{{/*
SiteWhere Zookeeper Port.
*/}}
{{- define "sitewhere.zookeeper.port" -}}
{{- if (index .Values "sitewhere-infra-core" "kafka" "enabled") -}}
{{- index .Values "sitewhere-infra-core" "kafka" "zookeeper" "ports" "client" "containerPort" -}}
{{- else -}}
{{- index .Values "sitewhere-infra-core" "kafka" "zookeeper_port" -}}
{{- end -}}
{{- end -}}

{{/*
SiteWhere Kafka Hostname.
*/}}
{{- define "sitewhere.kafka.host" -}}
{{- if (index .Values "sitewhere-infra-core" "kafka" "enabled") -}}
{{ include "sitewhere.fullname" . }}-kafka
{{- else -}}
{{- index .Values "sitewhere-infra-core" "kafka" "kafka_host" -}}
{{- end -}}
{{- end -}}

{{/*
SiteWhere Kafka Port.
*/}}
{{- define "sitewhere.kafka.port" -}}
{{- if (index .Values "sitewhere-infra-core" "kafka" "enabled") -}}
{{- index .Values "sitewhere-infra-core" "kafka" "headless" "port" -}}
{{- else -}}
{{- index .Values "sitewhere-infra-core" "kafka" "kafka_port" -}}
{{- end -}}
{{- end -}}
