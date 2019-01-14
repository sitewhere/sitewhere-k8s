# SiteWhere 2.0 Infrastructure Helm Chart

## Installing on a developer machine

```console
helm install --name sitewhere-infra \
  --set kafka.persistence.storageClass=hostpath \
  --set kafka.zookeeper.persistence.storageClass=hostpath \
  --set kafka.replicas=1 \
  --set kafka.zookeeper.replicaCount=1 \
  --set consul.Replicas=1 \
  sitewhere-infra-core
```

## Uninstalling the Helm Chart

```console
helm del sitewhere-infra --purge
```
