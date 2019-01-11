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

### Infrastructure Persistence Configuration

| Parameter                        | Description                                          | Default                          |
| :------------------------------- | :--------------------------------------------------- | :------------------------------- |
| persistence.storageClass         | Storage Class used in Persistence Volume Claims      | rook-ceph-block                  |
| persistence.storage              | Storage Size of Persistence Volume Claim             | 10Gi                             |

### Zookeeper Configration

| Parameter                        | Description                                          | Default                          |
| :------------------------------- | :--------------------------------------------------- | :------------------------------- |
| infra.zookeeper.image            | Zookeeper container image                            | wurstmeister/zookeeper           |
| infra.zookeeper.replicaCount     | Zookeeper Replica Count                              | 1                                |
| infra.zookeeper.service.type     | Zookeeper Service Type                               | ClusterIP                        |
| infra.zookeeper.service.port     | Zookeeper Service Port                               | 2181                             |
| infra.zookeeper.zoonavigator.image | Zookeeper Navigator container image                | elkozmon/zoonavigator-web:latest |
| infra.zookeeper.zoonavigator.service.type | Zookeeper Navigator Service Type            | ClusterIP                        |
| infra.zookeeper.zoonavigator.service.port | Zookeeper Service Port                      | 8000                             |
| infra.zookeeper.api.image                 | Zookeeper API container image               | elkozmon/zoonavigator-api:latest |

### Kafka Configuration

| Parameter                        | Description                                          | Default                          |
| :------------------------------- | :--------------------------------------------------- | :------------------------------- |
| infra.kafka.image                | Apache Kafka container image                         | wurstmeister/kafka:1.0.0         |
| infra.kafka.replicaCount         | Apache Kafka Replica Count                           | 1                                |
| infra.kafka.service.type         | Apache Kafka Service Type                            | ClusterIP                        |
| infra.kafka.service.inside.port  | Apache Kafka Inside Service Port                     | 9092                             |
| infra.kafka.service.outside.port | Apache Kafka Outside Service Port                    | 9094                             |

### MongoDB Configuration

| Parameter                        | Description                                     | Default                          |
| :------------------------------- | :---------------------------------------------- | :------------------------------- |
| infra.mongodb.image              | MongoDB container image                         | mongo:3                          |
| infra.mongodb.enabled            | Enable MongoDB                                  | `true`                           |
| infra.mongodb.replicaCount       | MongoDB Replica Count                           | 1                                |
| infra.mongodb.service.type       | MongoDB Service Type                            | ClusterIP                        |
| infra.mongodb.service.port       | MongoDB Service Port                            | 27017                            |

### Cassandra Configuration

| Parameter                        | Description                                     | Default                          |
| :------------------------------- | :---------------------------------------------- | :------------------------------- |
| infra.cassandra.image            | Cassandra container image                       | cassandra:3.11                   |
| infra.cassandra.enabled          | Enable Cassandra                                | `false`                          |
| infra.cassandra.replicaCount     | Cassandra Replica Count                         | 1                                |
| infra.cassandra.service.type     | Cassandra Service Type                          | ClusterIP                        |
| infra.cassandra.service.port     | Cassandra Service Port                          | 9042                             |

#### InfluxDB Configuration

| Parameter                        | Description                                     | Default                          |
| :------------------------------- | :---------------------------------------------- | :------------------------------- |
| infra.influxdb.image             | InfluxDB container image                        | influxdb:1.3-alpine              |
| infra.influxdb.enabled           | Enable InfluxDB                                 | `false`                          |
| infra.influxdb.replicaCount      | InfluxDB Replica Count                          | 1                                |
| infra.influxdb.service.type      | InfluxDB Service Type                           | ClusterIP                        |
| infra.influxdb.service.port      | InfluxDB Service Port                           | 8086                             |
