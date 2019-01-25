# Helm Charts for Running SiteWhere 2.0

SiteWhere provides a comprehensive Helm chart which takes care of 
orchestration of the many components that make up a SiteWhere
instance. By configuring chart parameters, the system may be 
easily customized for specific application requirements.

## Install Rook

To support replication of persistent data across multiple
Kubernetes nodes, SiteWhere leverages [Rook.io](https://rook.io/)
to provide the necessary distributed infrastructure. If a k8s
node fails, the data it persists will be available when 
containers start on other nodes in the cluster. To install
Rook, execute the following:

```console
kubectl create -f ../rook/operator.yaml
kubectl create -f ../rook/cluster.yaml
kubectl create -f ../rook/storageclass.yaml
```

With the default chart settings, Rook is utilized by the Zookeeper, 
Kafka, and MongoDB containers to prevent data loss in cases where 
nodes crash unexpectedly.

## Start SiteWhere

The Helm chart supports many different system configurations
which may be enabled by passing parameters to the chart.
Some of the common configurations are covered below.

### Add SiteWhere Helm Repository

SiteWhere provides a Helm chart repository which contains
the primary chart as well as subordinate charts for 
aspects such as core infrastructure and databases. To 
add the repository, run the following commands:

```console
helm repo add sitewhere https://sitewhere.io/helm-charts
helm repo update
```

### Running with High Availability

To start default configuration which provides a highly-available
infrastructure, run:

```console
helm install --name sitewhere sitewhere/sitewhere
```

This configuration deploys all of the SiteWhere microservices along
with a HA infrastructure which includes:

- Three-node HA Consul cluster
- Three-node HA Zookeeper cluster
- Three-broker Kafka cluster with HA settings
- Three-node MongoDB replica set (primary/secondary/arbiter)

This configuration has significant resource requirements and
should either be run on multiple Kubernetes nodes or a single
node with at least 16GB of RAM.

### Running with Restricted Resources

If you wish to run SiteWhere in a low resource cluster, use the `minimal` 
profile by installing this Helm Chart with the following command:

```console
helm install --name sitewhere --set services.profile=minimal sitewhere/sitewhere
```

This will run only the core microservices required to for basic
system functionality, but with HA infrastructure still in place. To
run a non-HA system for cases such as local development, clone
the repository and use the following configuration:

```console
helm install --name sitewhere -f ./sitewhere/dev-values.yaml ./sitewhere
```

### Running without Rook.io

If you don't need Rook.io, you can skip the Rook.io install and install
SiteWhere Helm Chart setting the `persistence.storageClass` property to
other than `rook-ceph-block`, for example to use `hostpath` Persistence
Storage Class, use the following command:  

```console
helm install --name sitewhere --set persistence.storageClass=hostpath sitewhere/sitewhere
```

### Removing SiteWhere

To remove sitewhere, execute the following command

```console
helm del sitewhere --purge
```

## Upgrading sitewhere

To upgrade the release of sitewhere, for example, for using a different
configuration, use `helm upgrade`.

For example, to use [InfluxDB](https://www.influxdata.com/), set the
`sitewhere-infra-database.influxdb.enabled` configuration flag to `true`
using the following command:

```console
helm upgrade --set sitewhere-infra-database.influxdb.enabled=true \
  sitewhere \
  sitewhere/sitewhere
```

## Using private repositories

```console
kubectl create secret docker-registry sitewhere-harbor-cred \
--docker-server=https://<docker.repository.fqdn> \
--docker-username=sitewhere \
--docker-password=SiteWhere1234 \
--docker-email=sitewhere@sitewhere.com
secret/sitewhere-harbor-cred created
```

## Removing SiteWhere Data for clean system start

In order to remove all SiteWhere data and start with a clean system, you need remove
the Persistence Volume Claim that SiteWhere creates. To do that, run the following commands:

```console
kubectl delete pvc -l release=sitewhere
```

## Uninstall Rook

If you wish to uninstall Rook.io follow the instructions of
this [document](https://rook.io/docs/rook/v0.9/ceph-teardown.html)
on how to uninstall Rook.io from Kuberntes.
