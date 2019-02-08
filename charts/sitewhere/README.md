# SiteWhere 2.0 Helm Chart

## Prerequisites Details

* Kubernetes 1.8+
* Rook v0.9+

## Chart Details

This chart will do the following:

* Deploy SiteWhere 2.0 infrastructure
* Deploy SiteWhere 2.0 microservices

## Installaing the Chart

### Add SiteWhere Helm

Before installing SiteWhere helm charts, you need to add the [SiteWhere helm repository](https://sitewhere.io/helm-charts) to your helm client.

```console
helm repo add sitewhere https://sitewhere.io/helm-charts
```

Then you need to update your local helm repository

```console
helm repo update
```

### Install Chart

To install the chart with the release name `sitewhere` execute:

```console
helm install --name sitewhere sitewhere/sitewhere
```

### Install in a Developer Machine

```console
helm install --name sitewhere \
  -f ./sitewhere/values-dev.yaml \
  sitewhere
```

### Remove Installed Helm Chart

```console
helm del sitewhere --purge
```

### Delete SiteWhere Data

```console
kubectl delete pvc -l release=sitewhere
```

## Install Kafka Manager

Assuming your sitewhere install name is `sitewhere`

```console
helm install --name kafka-manager \
  --set zkHosts=sitewhere-zookeeper:2181 stable/kafka-manager
```

Port-Forware Kafka Manager UI

```console
kubectl port-forward deployment/kafka-manager-kafka-manager 9000 9000
```