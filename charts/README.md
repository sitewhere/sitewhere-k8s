# Helm Charts for Running SiteWhere 2.0

To deploy SiteWhere default configuration in a Kubernetes clusters as a Helm Chart, run the command:

## Install Rook

If you need File, Block, and Object Storage Services for your Cloud-Native Environments, install Rook.io, with the following commands:

```console
kubectl create -f ../rook/operator.yaml
kubectl create -f ../rook/cluster.yaml
kubectl create -f ../rook/storageclass.yaml
```

## Start SiteWhere

To start default configuration run:

```console
helm repo add sitewhere https://sitewhere.io/helm-charts
helm repo update
helm install --name sitewhere sitewhere/sitewhere
```

Also, if you wish to run SiteWhere in a low resource cluster, use the
minimal recipes and install this Helm Chart with the following command:

```console
helm install --name sitewhere --set services.profile=minimal sitewhere/sitewhere
```

If you don't need Rook.io, you can skip the Rook.io install and install
SiteWhere Helm Chart setting the `persistence.storageClass` property to
other than `rook-ceph-block`, for example to use `hostpath` Persistence
Storage Class, use the following command:  

```console
helm install --name sitewhere --set persistence.storageClass=hostpath sitewhere/sitewhere
```

To remove sitewhere, execute the following command

```console
helm del sitewhere --purge
```

## Upgrading sitewhere

To upgrade the release of sitewhere, for example, for using a different
configuration, use `helm upgrade`.

For example, to use [InfluxDB](https://www.influxdata.com/), set the 
`infra.influxdb.enabled` configuration flag to `true` using the following command:

```console
helm upgrade --set infra.influxdb.enabled=true sitewhere ./sitewhere
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
