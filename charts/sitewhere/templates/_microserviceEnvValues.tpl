{{/* Generate Environment Variables */}}
{{- define "sitewhere.microservice.envValues" -}}
env:
  - name: "sitewhere.k8s.pod.ip"
    valueFrom:
      fieldRef:
        fieldPath: status.podIP
  - name: "sitewhere.namespace"
    valueFrom:
      fieldRef:
        fieldPath: metadata.namespace
  - name: "sitewhere.instance.id"
    value: "{{ .Release.Name }}"
  - name: "sitewhere.metrics.port"
    value: {{ .Values.services.metrics.port | quote }}
  - name: "sitewhere.zookeeper.host"
    value: "{{ include "sitewhere.zookeeper.host" . }}"
  - name: "sitewhere.zookeeper.port"
    value: "{{ include "sitewhere.zookeeper.port" . }}"
  - name: "sitewhere.kafka.bootstrap.servers"
    value: "{{ include "sitewhere.kafka.host" . }}:{{ include "sitewhere.kafka.port" . }}"
  - name: "sitewhere.kafka.defaultTopicReplicationFactor"
    value: "{{ .Values.services.kafka.defaultTopicReplicationFactor }}"
  - name: "sitewhere.grpc.maxRetryCount"
    value: "{{ .Values.services.grpc.maxRetryCount }}"
  - name: "sitewhere.grpc.initialBackoffSeconds"
    value: "{{ .Values.services.grpc.initialBackoffSeconds }}"
  - name: "sitewhere.grpc.maxBackoffSeconds"
    value: "{{ .Values.services.grpc.maxBackoffSeconds }}"
  - name: "sitewhere.grpc.backoffMultiplier"
    value: "{{ .Values.services.grpc.backoffMultiplier }}"
  - name: "sitewhere.grpc.resolveFQDN"
    value: "{{ .Values.services.grpc.resolveFQDN }}"
  - name: "mqtt.host"
    value: "{{ include "sitewhere.fullname" . }}-mosquitto-svc"
  - name: "mongodb.host"
    value: "{{ include "sitewhere.mongodb.fullname" . }}"
  - name: "mongodb.replicaset"
    value: "{{ .Values.infra.mongodb.replicaset }}"
  - name: "tenantsdb.url"
    value: "jdbc:postgresql://{{ include "sitewhere.name" . }}-tenantsdb-headless.{{ .Release.Namespace }}.svc.cluster.local/tenantsdb"
  - name: "tenantsdb.username"
    value: "{{ index .Values "sitewhere-infra-database" "tenantsdb" "postgresqlUsername" }}"
  - name: "tenantsdb.password"
    valueFrom:
      secretKeyRef:
        name: {{ template "sitewhere.name" . }}-tenantsdb
        key: postgresql-password
  - name: "warp10.url"
    value: "http://warp10.{{ .Release.Namespace }}.svc.cluster.local:8080/api/v0"
  - name: "LOGGING_LEVEL_SITEWHERE"
    value: "{{ .Values.services.logging.sitewhere.level }}"
  - name: "LOGGING_LEVEL_SITEWHERE_GRPC"
    value: "{{ .Values.services.logging.sitewhere.grpc.level }}"
  - name: "LOGGING_LEVEL_SITEWHERE_KAFKA"
    value: "{{ .Values.services.logging.sitewhere.kafka.level }}"
  - name: "LOGGING_LEVEL_GRPC_INTERNAL"
    value: "{{ .Values.services.logging.grpc.level }}"
  - name: "LOGGING_LEVEL_SPRING_BOOT"
    value: "{{ .Values.services.logging.spring.boot.level }}"
  - name: "LOGGING_LEVEL_SPRING_CONTEXT"
    value: "{{ .Values.services.logging.spring.context.level }}"
  - name: "LOGGING_LEVEL_SPRING_SECURITY"
    value: "{{ .Values.services.logging.spring.security.level }}"
  - name: "LOGGING_LEVEL_KAFKA"
    value: "{{ .Values.services.logging.kafka.level }}"
  - name: "LOGGING_LEVEL_ZOOKEEPER"
    value: "{{ .Values.services.logging.zookeeper.level }}"
  - name: "LOGGING_LEVEL_MONGODB"
    value: "{{ .Values.services.logging.mongodb.level }}"
{{- if include "infra.cassandra.enabled" . }}
  - name: "cassandra.contact.points"
    value: "{{ include "sitewhere.fullname" . }}-cassandra-svc"
{{- end }}
{{- if include "infra.influxdb.enabled" . }}
  - name: "influxdb.host"
    value: "{{ include "sitewhere.fullname" . }}-influxdb"
  - name: "influxdb.port"
    value: "{{ index .Values "sitewhere-infra-database" "influxdb" "config" "http" "bind_address" }}"
{{- end }}
{{- end -}}
