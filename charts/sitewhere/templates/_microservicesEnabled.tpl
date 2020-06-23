{{/*
  | Microservice             | Defaul Profile | Minimal Profile |
  | ------------------------ | -------------- | --------------- |
  | Asset Management         | ✓              | ✓               |
  | Device Management        | ✓              | ✓               |
  | Event Management         | ✓              | ✓               |
  | Event Sources            | ✓              | ✓               |
  | Inbound Processing       | ✓              | ✓               |
  | Instance Managemwnt      | ✓              | ✓               |
  | Outbound Connectors      | ✓              | ✓               |
  | Tenant Management        | ✓              | ✓               |
  | User Management          | ✓              | ✓               |
  | Web Rest                 | ✓              | ✓               |
  | Batch Operations         | ✓              | ✗               |
  | Command Delivery         | ✓              | ✗               |
  | Device Registration      | ✓              | ✗               |
  | Device State             | ✓              | ✗               |
  | Event Search             | ✓              | ✗               |
  | Label Generation         | ✓              | ✗               |
  | Rule Processing          | ✓              | ✗               |
  | Schedule Management      | ✓              | ✗               |
  | Streaming Media          | ✓              | ✗               |
*/}}
{{/*
Returns true if Asset Management Microservice is enabled.
*/}}
{{- define "microservices.asset_management.enabled" -}}
{{- if (or (eq .Values.services.profile "default") (.Values.services.asset_management.enabled)) -}}
-
{{- end -}}
{{- end -}}
 
{{/*
Returns true if Device Management Microservice is enabled.
*/}}
{{- define "microservices.device_management.enabled" -}}
{{- if (or (eq .Values.services.profile "default") (.Values.services.device_management.enabled)) -}}
-
{{- end -}}
{{- end -}}

{{/*
Returns true if Event Management Microservice is enabled.
*/}}
{{- define "microservices.event_management.enabled" -}}
{{- if (or (eq .Values.services.profile "default") (.Values.services.event_management.enabled)) -}}
-
{{- end -}}
{{- end -}}

{{/*
Returns true if Event Sources Microservice is enabled.
*/}}
{{- define "microservices.event_sources.enabled" -}}
{{- if (or (eq .Values.services.profile "default") (.Values.services.event_sources.enabled)) -}}
-
{{- end -}}
{{- end -}}

{{/*
Returns true if Inbound Processing Microservice is enabled.
*/}}
{{- define "microservices.inbound_processing.enabled" -}}
{{- if (or (eq .Values.services.profile "default") (.Values.services.inbound_processing.enabled)) -}}
-
{{- end -}}
{{- end -}}

{{/*
Returns true if Instance Management Microservice is enabled.
*/}}
{{- define "microservices.instance_management.enabled" -}}
{{- if (or (eq .Values.services.profile "default") (.Values.services.instance_management.enabled)) -}}
-
{{- end -}}
{{- end -}}

{{/*
Returns true if Outbound Connectors Microservice is enabled.
*/}}
{{- define "microservices.outbound_connectors.enabled" -}}
{{- if (or (eq .Values.services.profile "default") (.Values.services.outbound_connectors.enabled)) -}}
-
{{- end -}}
{{- end -}}

{{/*
Returns true if Tenant Management Microservice is enabled.
*/}}
{{- define "microservices.tenant_management.enabled" -}}
{{- if (or (eq .Values.services.profile "default") (.Values.services.tenant_management.enabled)) -}}
-
{{- end -}}
{{- end -}}

{{/*
Returns true if User Management Microservice is enabled.
*/}}
{{- define "microservices.user_management.enabled" -}}
{{- if (or (eq .Values.services.profile "default") (.Values.services.user_management.enabled)) -}}
-
{{- end -}}
{{- end -}}

{{/*
Returns true if Web REST Microservice is enabled.
*/}}
{{- define "microservices.web_rest.enabled" -}}
{{- if (or (eq .Values.services.profile "default") (.Values.services.web_rest.enabled)) -}}
-
{{- end -}}
{{- end -}}

{{/*
Returns true if Batch Operations Microservice is enabled.
*/}}
{{- define "microservices.batch_operations.enabled" -}}
{{- if (or (eq .Values.services.profile "default") (.Values.services.batch_operations.enabled)) -}}
-
{{- end -}}
{{- end -}}

{{/*
Returns true if Command Delivery Microservice is enabled.
*/}}
{{- define "microservices.command_delivery.enabled" -}}
{{- if (or (eq .Values.services.profile "default") (.Values.services.command_delivery.enabled)) -}}
-
{{- end -}}
{{- end -}}

{{/*
Returns true if Device Registration Microservice is enabled.
*/}}
{{- define "microservices.device_registration.enabled" -}}
{{- if (or (eq .Values.services.profile "default") (.Values.services.device_registration.enabled)) -}}
-
{{- end -}}
{{- end -}}

{{/*
Returns true if Device State Microservice is enabled.
*/}}
{{- define "microservices.device_state.enabled" -}}
{{- if (or (eq .Values.services.profile "default") (.Values.services.device_state.enabled)) -}}
-
{{- end -}}
{{- end -}}

{{/*
Returns true if Event Search Microservice is enabled.
*/}}
{{- define "microservices.event_search.enabled" -}}
{{- if (or (eq .Values.services.profile "default") (.Values.services.event_search.enabled)) -}}
-
{{- end -}}
{{- end -}}

{{/*
Returns true if Label Generation Microservice is enabled.
*/}}
{{- define "microservices.label_generation.enabled" -}}
{{- if (or (eq .Values.services.profile "default") (.Values.services.label_generation.enabled)) -}}
-
{{- end -}}
{{- end -}}

{{/*
Returns true if Rule Processing Microservice is enabled.
*/}}
{{- define "microservices.rule_processing.enabled" -}}
{{- if (or (eq .Values.services.profile "default") (.Values.services.rule_processing.enabled)) -}}
-
{{- end -}}
{{- end -}}

{{/*
Returns true if Schedule Management Microservice is enabled.
*/}}
{{- define "microservices.schedule_management.enabled" -}}
{{- if (or (eq .Values.services.profile "default") (.Values.services.schedule_management.enabled)) -}}
-
{{- end -}}
{{- end -}}

{{/*
Returns true if Streaming Media Microservice is enabled.
*/}}
{{- define "microservices.streaming_media.enabled" -}}
{{- if (or (eq .Values.services.profile "default") (.Values.services.streaming_media.enabled)) -}}
-
{{- end -}}
{{- end -}}