# Helm Charts for Running SiteWhere 2.0

SiteWhere provides a comprehensive Helm chart which takes care of 
orchestration of the many components that make up a SiteWhere
instance. By configuring chart parameters, the system may be 
easily customized for specific application requirements.

## Add SiteWhere Helm Repository

Before you deploy SiteWhere using Helm, you need to add SiteWhere Helm Repository.

```console
helm repo add sitewhere https://sitewhere.io/helm-charts
helm repo update
```

## Deploy SiteWhere using the default configuration

To start default configuration run:

```console
helm install --name sitewhere sitewhere/sitewhere
```

## Deploy SiteWhere using Rook

To support replication of persistent data across multiple
Kubernetes nodes, SiteWhere leverages [Rook.io](https://rook.io/)
to provide the necessary distributed infrastructure. If a k8s
node fails, the data it persists will be available when 
containers start on other nodes in the cluster. To install
Rook, execute the following:

### Install Rook

```console
kubectl create -f ../rook/operator.yaml
kubectl create -f ../rook/cluster.yaml
kubectl create -f ../rook/storageclass.yaml
```

### Install SiteWhere with Rook

```console
helm install --name sitewhere -f values-rook-ceph.yaml sitewhere/sitewhere
```

## Deploy SiteWhere using minimal configuration

Also, if you wish to run SiteWhere in a low resource cluster, use the
minimal recipes and install this Helm Chart with the following command:

```console
helm install --name sitewhere --set services.profile=minimal sitewhere/sitewhere
```

You can use the `values-dev.yaml` for running on a developer machine:

```console
helm install --name sitewhere -f values-dev.yaml sitewhere/sitewhere
```

## Deploy SiteWhere using a different storageClass

If you need to use another `storageClass`, for example `<your-storage-class>`,
the start SiteWhere using the following configuration:  

```console
helm install --name sitewhere \
--set sitewhere-infra-core.kafka.persistence.storageClass=<your-storage-class> \
--set sitewhere-infra-core.kafka.zookeeper.persistence.storageClass=<your-storage-class> \
--set sitewhere-infra-database.mongodb.persistence.storageClass=<your-storage-class> \
--set sitewhere-infra-database.cassandra.persistence.storageClass=<your-storage-class> \
--set sitewhere-infra-database.influxdb.persistence.storageClass=<your-storage-class> \
sitewhere/sitewhere
```

## Undeploy SiteWhere

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
