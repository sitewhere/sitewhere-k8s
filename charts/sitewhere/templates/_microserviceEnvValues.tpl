{{- define "sitewhere.microserviceEnvValues" -}}
- name: "sitewhere.k8s.pod.ip"
  valueFrom:
    fieldRef:
      fieldPath: status.podIP
- name: "sitewhere.instance.id"
  value: "{{ .Release.Name }}"
- name: "sitewhere.tracer.server"
  value: "{{ include "sitewhere.fullname" . }}-jaeger-svc"
- name: "sitewhere.zookeeper.host"
  value: "{{ include "sitewhere.zookeeper.host" . }}"
- name: "sitewhere.zookeeper.port"
  value: "{{ include "sitewhere.zookeeper.port" . }}"
- name: "sitewhere.kafka.bootstrap.servers"
  value: "{{ include "sitewhere.kafka.host" . }}:{{ include "sitewhere.kafka.port" . }}"
- name: "mqtt.host"
  value: "{{ include "sitewhere.fullname" . }}-mosquitto-svc"
- name: "mongodb.host"
  value: "{{ include "sitewhere.mongodb.fullname" . }}"
- name: "mongodb.replicaset"
  value: "rs0"
- name: "sitewhere.consul.host"
  value: "{{ include "sitewhere.consul.fullname" . }}"
- name: "sitewhere.consul.port"
  value: "8500"
- name: "LOGGING_LEVEL_SITEWHERE"
  value: "{{ .Values.services.logging.sitewhere.level }}"
- name: "LOGGING_LEVEL_SITEWHERE_GRPC"
  value: "{{ .Values.services.logging.sitewhere.grpc.level }}"
- name: "LOGGING_LEVEL_KAFKA"
  value: "{{ .Values.services.logging.kafka.level }}"
- name: "LOGGING_LEVEL_ZOOKEEPER"
  value: "{{ .Values.services.logging.zookeeper.level }}"
{{- if include "infra.cassandra.enabled" . }}
- name: "cassandra.contact.points"
  value: "{{ include "sitewhere.fullname" . }}-cassandra-svc"
{{- end }}
{{- if include "infra.influxdb.enabled" . }}
- name: "influxdb.host"
  value: "{{ include "sitewhere.fullname" . }}-influxdb-svc"
- name: "influxdb.port"
  value: "{{ index .Values "sitewhere-infra-database" "influxdb" "config" "http" "bind_address" }}"
{{- end }}
{{- end -}}
