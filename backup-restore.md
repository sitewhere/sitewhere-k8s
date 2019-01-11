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

### Upscale SiteWhere Microservices

```console
kubectl scale deploy --replicas=1 -l sitewhere.io/role=microservice
```

## Restore Procedure

### Gracefully Downscale SiteWhere Microservices

```console
kubectl scale deploy --replicas=0 -l sitewhere.io/role=microservice
```

### Restore MongoDB Database

```console
kubectl apply -f utils/sitewhere-mongodb-restore-job.yaml
```

### Upscale SiteWhere Microservices

```console
kubectl scale deploy --replicas=1 -l sitewhere.io/role=microservice
```