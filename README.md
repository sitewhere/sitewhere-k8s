# SiteWhere Kubernetes Orchestration

SiteWhere / Kubernetes integration including Helm Charts

## Chart Details

This chart will do the following:

* Deploy SiteWhere Infrastructure:
  * Deploy [MongoDB](https://www.mongodb.com/)
  * Deploy [Apache Kafka](https://kafka.apache.org/)
  * Deploy [Apache Zookeeper](https://zookeeper.apache.org/)
  * Deploy [Jaeger](https://www.jaegertracing.io/)
  * Deploy [Eclipse Mosquitto](https://mosquitto.org/)
* Deploy SiteWhere Microservices. The table bellow describes the microservices deployed base on the profile selected.

  | Microservice             | Defaul Profile | Minimal Profile |
  | ------------------------ | -------------- | --------------- |
  | Asset Management         | ✓              | ✓               |
  | Device Management        | ✓              | ✓               |
  | Event Management         | ✓              | ✓               |
  | Event Sources            | ✓              | ✓               |
  | Inbound Processing       | ✓              | ✓               |
  | Instance Managemwnt      | ✓              | ✓               |
  | Outbound Connectors      | ✓              | ✓               |
  | Tenant Management        | ✓              | ✓               |
  | User Management          | ✓              | ✓               |
  | Web Rest                 | ✓              | ✓               |
  | Batch Operations         | ✓              | ✗               |
  | Command Delivery         | ✓              | ✗               |
  | Device Registration      | ✓              | ✗               |
  | Device State             | ✓              | ✗               |
  | Event Search             | ✓              | ✗               |
  | Label Generation         | ✓              | ✗               |
  | Rules Processing         | ✓              | ✗               |
  | Schedule Management      | ✓              | ✗               |
  | Streaming Media          | ✓              | ✗               |
  
* Expose Web Rest port 8080 on an external LoadBalancer

## Installing the Chart

To install SiteWhere Helm Chart follow [this](./charts/README.md) instructions.

## Configuration

The following tables list the configurable parameters of the SiteWhere chart and their default values.

### Infrastructure Configration

| Parameter                        | Description                                          | Default                          |
| ---------------------------------| -----------------------------------------------------|----------------------------------|
| infra.image.registry             | Image registry for infrastructure container images   | docker.io                        |
| infra.image.pullPolicy           | Image pull policy for infrastructure images          | IfNotPresent                     |
| infra.image.imagePullSecrets     | Image pull secrets for infrastructure images         | `nil`                            |

#### Zookeeper Configration

| Parameter                        | Description                                          | Default                          |
| ---------------------------------| -----------------------------------------------------|----------------------------------|
| infra.zookeeper.image            | Zookeeper container image                            | wurstmeister/zookeeper           |
| infra.zookeeper.replicaCount     | Zookeeper Replica Count                              | 1                                |
| infra.zookeeper.service.type     | Zookeeper Service Type                               | ClusterIP                        |
| infra.zookeeper.service.port     | Zookeeper Service Port                               | 2181                             |
| infra.zookeeper.zoonavigator.image | Zookeeper Navigator container image                | elkozmon/zoonavigator-web:latest |
| infra.zookeeper.zoonavigator.service.type | Zookeeper Navigator Service Type            | ClusterIP                        |
| infra.zookeeper.zoonavigator.service.port | Zookeeper Service Port                      | 8000                             |
| infra.zookeeper.api.image                 | Zookeeper API container image               | elkozmon/zoonavigator-api:latest |

#### Kafka Configuration

| Parameter                             | Description                                          | Default                          |
| --------------------------------------| -----------------------------------------------------|----------------------------------|
| infra.kafka.image                     | Apache Kafka container image                         | wurstmeister/kafka:1.0.0         |
| infra.kafka.replicaCount              | Apache Kafka Replica Count                           | 1                                |
| infra.kafka.service.type              | Apache Kafka Service Type                            | ClusterIP                        |
| infra.kafka.service.inside.port       | Apache Kafka Inside Service Port                     | 9092                             |
| infra.kafka.service.outside.port      | Apache Kafka Outside Service Port                    | 9094                             |

#### Jaeger Configuration

| Parameter                             | Description                                    | Default                          |
| --------------------------------------| -----------------------------------------------|----------------------------------|
| infra.jaeger.image                    | Jaeger container image                         | jaegertracing/all-in-one         |
| infra.jaeger.replicaCount             | Jaeger Replica Count                           | 1                                |
| infra.jaeger.service.type             | Jaeger Service Type                            | ClusterIP                        |
| infra.jaeger.service.ports.zipkin     | Jaeger Zipkin Service Port                     | 9411                             |
| infra.jaeger.service.ports.ui         | Jaeger UI Service Port                         | 16686                            |

#### MongoDB Configuration

| Parameter                             | Description                                     | Default                          |
| --------------------------------------| ------------------------------------------------|----------------------------------|
| infra.mongodb.image                   | MongoDB container image                         | mongo:3                          |
| infra.mongodb.replicaCount            | MongoDB Replica Count                           | 1                                |
| infra.mongodb.service.type            | MongoDB Service Type                            | ClusterIP                        |
| infra.mongodb.service.port            | MongoDB Service Port                            | 27017                            |

#### Eclipse Mosquitto Configuration

| Parameter                             | Description                                     | Default                          |
| --------------------------------------| ------------------------------------------------|----------------------------------|
| infra.mosquitto.image                 | Eclipse Mosquitto container image               | eclipse-mosquitto:1.4.12         |
| infra.mosquitto.replicaCount          | Eclipse Mosquitto Replica Count                 | 1                                |
| infra.mosquitto.service.type          | Eclipse Mosquitto Service Type                  | ClusterIP                        |
| infra.mosquitto.service.port          | Eclipse Mosquitto Service Port                  | 1883                             |

### Microservice Configration

| Parameter                        | Description                                          | Default                          |
| ---------------------------------| -----------------------------------------------------|----------------------------------|
| services.profile                 | SiteWhere profile `default` or `minimal`             | `default`                        |
| services.image.registry          | Image registry for microservices container images    | docker.io                        |
| services.image.repository        | Image repository for microservices container images  | sitewhere                        |
| services.image.tag               | Image tag for microservices container images         | 2.0.0                            |
| services.image.pullPolicy        | Image pull policy for microservices images           | Never                            |
| services.image.imagePullSecrets  | Image pull secrets for microservices images          | `nil`                            |
| services.initContainers          | If `true`, microservices pod will wait for MongoDB.  | `true`                           |
