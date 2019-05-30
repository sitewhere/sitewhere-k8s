# SiteWhere Kubernetes Orchestration

[![Build Status](https://travis-ci.org/sitewhere/sitewhere-k8s.svg?branch=master)](https://travis-ci.org/sitewhere/sitewhere-k8s)

SiteWhere / Kubernetes integration including Helm Charts

## Chart Details

This chart will do the following:

* Deploy SiteWhere Infrastructure:
  * Deploy [MongoDB](https://www.mongodb.com/)
  * Deploy [Apache Kafka](https://kafka.apache.org/)
  * Deploy [Apache Zookeeper](https://zookeeper.apache.org/)
  * Deploy [Eclipse Mosquitto](https://mosquitto.org/)
* Deploy SiteWhere Microservices. The table bellow describes the microservices deployed base on the profile selected.

  | Microservice             | Defaul Profile | Minimal Profile |
  | :----------------------- | :------------- | :-------------- |
  | Asset Management         | ✓              | ✓               |
  | Device Management        | ✓              | ✓               |
  | Event Management         | ✓              | ✓               |
  | Event Sources            | ✓              | ✓               |
  | Inbound Processing       | ✓              | ✓               |
  | Instance Management      | ✓              | ✓               |
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
  | Rule Processing          | ✓              | ✗               |
  | Schedule Management      | ✓              | ✗               |
  | Streaming Media          | ✓              | ✗               |
  
* Expose Web Rest port 8080 on an external LoadBalancer
* Expose MQTT port 1886 on an external LoadBalancer.

## Installing the Chart

To install SiteWhere Helm Chart follow [this](./charts/README.md) instructions.

## Configuration

The following tables list the configurable parameters of the SiteWhere chart and their default values.

### Microservice Configration

| Parameter                                         | Description                                          | Default                          |
| :-------------------------------------------------| :--------------------------------------------------- | :------------------------------- |
| services.profile                                  | SiteWhere profile `default` or `minimal`             | `default`                        |
| services.debug                                    | Use debug images                                     | `false`                          |
| services.image.registry                           | Image registry for microservices container images    | `docker.io`                      |
| services.image.repository                         | Image repository for microservices container images  | `sitewhere`                      |
| services.image.tag                                | Image tag for microservices container images         | `latest`                         |
| services.image.pullPolicy                         | Image pull policy for microservices images           | `IfNotPresent`                   |
| services.image.imagePullSecrets                   | Image pull secrets for microservices images          | `nil`                            |
| services.health.port                              | Port used in the container for healthcheck           | `9003`                           |
| services.health.readinessProbe.initialDelay       | Initial delay of Readiness Probe                     | `120`                            |
| services.health.livenessProbe.initialDelaySeconds | Initial delay of Liveness Probe in sec               | `300`                            |
| services.health.livenessProbe.periodSeconds       | Period of the Liveness Probe in sec                  | `60`                             |

Each _microservice_ has the following configuration:

| Parameter                                            | Description                                     | Default           |
| :----------------------------------------------------| :---------------------------------------------- | :---------------- |
| services._microservice_.enabled                      | `true` if microservice is enabled               | `true`            |
| services._microservice_.image                        | Microservice container images                   | `_microservice_`  |
| services._microservice_.replicaCount                 | Microservice Replica Count                      | `1`               |
| services._microservice_.service.type                 | Microservice Service Type                       | `ClusterIP`       |
| services._microservice_.service.grpc.api.port        | Microservice gRPC API Service Port              | `9000`            |
| services._microservice_.service.grpc.management.port | Microservice gRPC Management Service Port       | `9001`            |

### Debug image ports

If you install SiteWhere in debug mode (using `--set services.debug=true`) each microservice will
expose two port (JDWP Port and JMX Port) for remote debuging. The following table show
the port that each microservice will expose, so that you can connect a remote debuger.

| Microservice             | JDWP Port        | JMX Port          |
| :----------------------- | :--------------- | :---------------- |
| Instance Managemwnt      | `8001`           | `1101`            |
| User Management          | `8002`           | `1102`            |
| Tenant Management        | `8003`           | `1103`            |
| Device Management        | `8004`           | `1104`            |
| Event Management         | `8005`           | `1105`            |
| Asset Management         | `8006`           | `1106`            |
| Event Sources            | `8007`           | `1107`            |
| Inbound Processing       | `8008`           | `1108`            |
| Label Generation         | `8009`           | `1109`            |
| Web Rest                 | `8010`           | `1110`            |
| Batch Operations         | `8011`           | `1111`            |
| Command Delivery         | `8012`           | `1112`            |
| Device Registration      | `8013`           | `1113`            |
| Device State             | `8014`           | `1114`            |
| Event Search             | `8015`           | `1115`            |
| Outbound Connectors      | `8016`           | `1116`            |
| Rule Processing          | `8017`           | `1117`            |
| Schedule Management      | `8018`           | `1118`            |
| Streaming Media          | `8019`           | `1119`            |

### Infrastructure Configration

#### Using External Kafka and Zookeeper infrastructure

In order to deploy SiteWhere using an external infrastructure of Kafka and Zookeeper,
install SiteWhere setting `sitewhere-infra-core.kafka.enabled=false`. Also you need to
provide the location of Apache Zookeeper (`hostname` and `port`) and Apache Kafka
Bootstrap servers location (`hostname` and `port`).

```console
helm install --name sitewhere \
  --set sitewhere-infra-core.kafka.enabled=false \
  --set sitewhere-infra-core.kafka.zookeeper_host=<zk-locahost> \
  --set sitewhere-infra-core.kafka.zookeeper_port=<zk-port> \
  --set sitewhere-infra-core.kafka.kafka_host=<kafka-locahost> \
  --set sitewhere-infra-core.kafka.kafka_port=<kafka-port> \
  sitewhere/sitewhere
```

#### General Infrastructure Configuration

| Parameter                        | Description                                          | Default                          |
| :------------------------------- | :--------------------------------------------------- | :------------------------------- |
| infra.profile                    | Available values: `mongodb` `cassandra` `influxdb`   | `mongodb`                        |
| infra.image.registry             | Image registry for infrastructure container images   | `docker.io`                      |
| infra.image.pullPolicy           | Image pull policy for infrastructure images          | `IfNotPresent`                   |
| infra.image.imagePullSecrets     | Image pull secrets for infrastructure images         | `nil`                            |

#### Eclipse Mosquitto Configuration

| Parameter                             | Description                                     | Default                          |
| :------------------------------------ | :---------------------------------------------- | :------------------------------- |
| infra.mosquitto.image                 | Eclipse Mosquitto container image               | `eclipse-mosquitto:1.4.12`       |
| infra.mosquitto.replicaCount          | Eclipse Mosquitto Replica Count                 | `1`                              |
| infra.mosquitto.service.type          | Eclipse Mosquitto Service Type                  | `LoadBalancer`                   |
| infra.mosquitto.service.port          | Eclipse Mosquitto Service Port                  | `1883`                           |
