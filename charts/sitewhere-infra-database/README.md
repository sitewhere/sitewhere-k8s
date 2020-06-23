# SiteWhere 2.2 Databases Helm Chart

## Installing on a developer machine

```console
helm install --name sitewhere-database \
  --set mongodb.replicaSet.enabled=false \
  --set mongodb.persistence.storageClass=hostpath \
  sitewhere-infra-database
```

## Uninstalling the Helm Chart

```console
helm del sitewhere-database --purge
```