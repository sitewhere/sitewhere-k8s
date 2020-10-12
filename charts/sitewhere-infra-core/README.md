# SiteWhere 2.1 Infrastructure Helm Chart

## Installing on a developer machine

```console
helm install  sitewhere-infra \
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
