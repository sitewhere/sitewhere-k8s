# Backup Procedure and Restore Procedures

This document provides SiteWhere 2.0 procedures for backup and restore of MongoDB.

## Backup Procedure

### Create Backup PVC

```console
kubectl apply -f utils/sitewhere-mongodb-dump-pvc.yaml
```

### Gracefully Downscale SiteWhere Microservices

```console
kubectl scale deploy --replicas=0 -l sitewhere.io/role=microservice
```

### Backup MongoDB Database

```console
kubectl apply -f utils/sitewhere-mongodb-dump-job.yaml
```

Wait for `sitewhere-mongodump` job to be completed.

```console
kubectl get job
```

```bash
NAME                  DESIRED   SUCCESSFUL   AGE
sitewhere-mongodump   1         1            7s
```

### Copy Backup Data Outside of the Cluster

```console
kubectl apply -f utils/sitewhere-mongodb-backup-pod.yaml
kubectl cp sitewhere-backup-admin-pod:/dump <YOUR_BACKUP_DIR>
kubectl delete -f utils/sitewhere-mongodb-backup-pod.yaml
```

### Upscale SiteWhere Microservices

```console
kubectl scale deploy --replicas=1 -l sitewhere.io/role=microservice
```

## Restore Procedure

### Gracefully Downscale SiteWhere Microservices

```console
kubectl scale deploy --replicas=0 -l sitewhere.io/role=microservice
```

### Copy Backup Data into the Cluster

```console
kubectl apply -f utils/sitewhere-mongodb-backup-pod.yaml
kubectl cp <YOUR_BACKUP_DIR> sitewhere-backup-admin-pod:/dump
kubectl delete -f utils/sitewhere-mongodb-backup-pod.yaml
```

### Restore MongoDB Database

```console
kubectl apply -f utils/sitewhere-mongodb-restore-job.yaml
```

### Upscale SiteWhere Microservices

```console
kubectl scale deploy --replicas=1 -l sitewhere.io/role=microservice
```