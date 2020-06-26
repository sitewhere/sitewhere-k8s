{{/* Common microservice logging */}}
{{- define "sitewhere.microservice.logging" -}}
logging:
  overrides:
    - logger: com.sitewhere
      level: info
    - logger: com.sitewhere.grpc.client
      level: info
    - logger: com.sitewhere.microservice.grpc
      level: info
    - logger: com.sitewhere.microservice.kafka
      level: info
    - logger: org.redisson
      level: info
{{- end -}}