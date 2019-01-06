# SiteWhere 2.0 Infrastructure Helm Chart

Running in developer machine

```sh
helm del sitewhere-infra --purge

helm install --name sitewhere-infra \
  --set kafka.persistence.storageClass=hostpath \
  --set kafka.zookeeper.persistence.storageClass=hostpath \
  --set kafka.replicas=1 \
  --set kafka.zookeeper.replicaCount=1 \
  --set consul.Replicas=1 \
  sitewhere-infra-core
```