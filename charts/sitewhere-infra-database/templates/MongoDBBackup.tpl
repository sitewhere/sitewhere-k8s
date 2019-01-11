{{ if .Values.mongodb.backup.enabled }}
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: {{ include "sitewhere-infra-database.fullname" . }}-dump-pvc
spec:
  storageClassName: rook-ceph-block
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
---
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: {{ include "sitewhere-infra-database.fullname" . }}-backup
spec:
  schedule: "{{ .Values.mongodb.backup.cron }}"
  jobTemplate:
    spec:
      template:
        spec:
          containers:
          - name: {{ include "sitewhere-infra-database.fullname" . }}-mongodump
            image: mongo
            command: ["mongodump", "--host", "{{ include "sitewhere-infra-database.fullname" . }}-mongodb", "--out", "/dump", "--verbose"]
            volumeMounts:
            - mountPath: "/dump"
              name: mongodump
          volumes:
          - name: mongodump
            persistentVolumeClaim:
              claimName: {{ include "sitewhere-infra-database.fullname" . }}-dump-pvc
          restartPolicy: Never
{{ end }}