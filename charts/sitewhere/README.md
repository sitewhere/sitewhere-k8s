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

```sh
helm repo add sitewhere https://sitewhere.io/helm-charts
```

Then you need to update your local helm repository

```sh
helm repo update
```

### Install Chart

To install the chart with the release name `sitewhere` execute:

```sh
helm install --name sitewhere sitewhere/sitewhere
```
