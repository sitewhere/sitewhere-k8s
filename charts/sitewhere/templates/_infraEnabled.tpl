{{/*
  | Service                  | Defaul Profile | Minimal Profile |
  | :----------------------- | :------------- | :-------------- |
  | MongoDB                  | ✓              | ✓               |
  | Cassandra                | ✓              | ✓               |
  | InfuxDB                  | ✓              | ✓               |
*/}}
{{/*
Returns true if MongoDB is enabled.
*/}}
{{- define "infra.mongodb.enabled" -}}
{{- if (or (eq .Values.infra.profile "mongodb") (.Values.infra.mongodb.enabled)) -}}
-
{{- end -}}
{{- end -}}

{{/*
Returns true if Cassandra is enabled.
*/}}
{{- define "infra.cassandra.enabled" -}}
{{- if (or (eq .Values.infra.profile "cassandra") (.Values.infra.cassandra.enabled)) -}}
-
{{- end -}}
{{- end -}}

{{/*
Returns true if InfluxDB is enabled.
*/}}
{{- define "infra.influxdb.enabled" -}}
{{- if (or (eq .Values.infra.profile "influxdb") (.Values.infra.influxdb.enabled)) -}}
-
{{- end -}}
{{- end -}}