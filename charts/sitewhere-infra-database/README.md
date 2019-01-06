# SiteWhere 2.0 Databases Helm Chart

Running in developer machine

```sh
helm del sitewhere-database --purge

helm install --name sitewhere-database \
  --set mongodb-replicaset.replicas=1 \
  --set mongodb-replicaset.persistentVolume.storageClass=hostpath \
  sitewhere-infra-database
```