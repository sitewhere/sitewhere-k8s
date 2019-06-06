{{/*
SiteWhere Zookeeper Hostname.
*/}}
{{- define "sitewhere.zookeeper.host" -}}
{{- if (index .Values "sitewhere-infra-core" "kafka" "enabled") -}}
{{- include "sitewhere.zookeeper.fullname" . -}}
{{- else -}}
{{- index .Values "sitewhere-infra-core" "zookeeper_host" -}}
{{- end -}}
{{- end -}}

{{/*
SiteWhere Zookeeper Port.
*/}}
{{- define "sitewhere.zookeeper.port" -}}
{{- if (index .Values "sitewhere-infra-core" "kafka" "enabled") -}}
{{- index .Values "sitewhere-infra-core" "cp-zookeeper" "clientPort" -}}
{{- else -}}
{{- index .Values "sitewhere-infra-core" "zookeeper_port" -}}
{{- end -}}
{{- end -}}

{{/*
SiteWhere Kafka Hostname.
*/}}
{{- define "sitewhere.kafka.host" -}}
{{- if (index .Values "sitewhere-infra-core" "kafka" "enabled") -}}
{{- include "sitewhere.kafka.fullname" . -}}
{{- else -}}
{{- index .Values "sitewhere-infra-core" "kafka_host" -}}
{{- end -}}
{{- end -}}

{{/*
SiteWhere Kafka Port.
*/}}
{{- define "sitewhere.kafka.port" -}}
{{- if (index .Values "sitewhere-infra-core" "kafka" "enabled") -}}
{{- 9092 -}}
{{- else -}}
{{- index .Values "sitewhere-infra-core" "kafka_port" -}}
{{- end -}}
{{- end -}}
