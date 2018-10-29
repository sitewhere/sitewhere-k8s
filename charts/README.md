# Helm Charts for Running SiteWhere 2.0

To deploy SiteWhere default configuration in a Kubernetes clusters as a Helm Chart, run the command:

## Install Rook

If you need File, Block, and Object Storage Services for your Cloud-Native Environments, install Rook.io, with the following commands:

```sh
kubectl create -f rook/operator.yaml
kubectl create -f rook/cluster.yaml
kubectl create -f rook/storageclass.yaml
```

## Start SiteWhere

To start default configuration run:

```sh
helm install --name sitewhere ./sitewhere
```

Also, if you wish to run SiteWhere in a low resource cluster, use the 
minimal recipes and install this Helm Chart with the following command:

```sh
    helm install --name sitewhere --set services.profile=minimal ./sitewhere
```

If you don't need Rook.io, you can skip the Rook.io install and install
SiteWhere Helm Chart setting the `persistence.storageClass` property to
other than `rook-ceph-block`, for example to use `hostpath` Persistence
Storage Class, use the following command:  

```sh
helm install --name sitewhere --set persistence.storageClass=hostpath ./sitewhere
```

To remove sitewhere, execute the following command

```sh
helm del --purge sitewhere
```

## Using private repositories

```sh
kubectl create secret docker-registry sitewhere-harbor-cred \
--docker-server=https://<docker.repository.fqdn> \
--docker-username=sitewhere \
--docker-password=SiteWhere1234 \
--docker-email=sitewhere@sitewhere.com 
secret/sitewhere-harbor-cred created
```

## Uninstall Rook

To uninstall Rook.io use the following command:

```sh
helm delete --purge rook-ceph
```

Also, that a look at this [document](https://rook.io/docs/rook/v0.8/ceph-teardown.html)
for further instructions on how to uninstall Rook.io from Kuberntes.