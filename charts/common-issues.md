# Common Issues

## Troubleshooting Techniques

### Rook Instalation

Verify the `rook-ceph-agent` pods are `Running`

```console
kubectl -n rook-ceph-system get pod
```

Verify that there are not error on `rook-ceph-agent` pods by running:

```console
kubectl -n rook-ceph-system get pod -l app=rook-ceph-agent -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.containerStatuses[0].lastState.terminated.message}{"\n"}{end}'
```

### Running on MiniKube

If you are running on `minikube` you can skip using `Rook.io`
and use the `values-dev.yaml`.

```console
helm install  sitewhere \
-f ./sitewhere/values-dev.yaml \
--set sitewhere-infra-database.mongodb.persistence.storageClass=standard \
--set sitewhere-infra-core.cp-kafka.persistence.storageClass=standard \
--set sitewhere-infra-core.cp-zookeeper.persistence.dataLogDirStorageClass=standard \
sitewhere/sitewhere
```

### Running on GKE

```console
helm install  sitewhere \
sitewhere/sitewhere
```

### Running on Amazon EKS

```console
helm install  sitewhere \
-f values-eks.yaml \
sitewhere/sitewhere
```

### Minimal evironment with `hostpath` storageClass

```console
helm install  sitewhere \
--set services.profile=minimal \
--set sitewhere-infra-core.cp-zookeeper.servers=1 \
--set sitewhere-infra-database.mongodb.persistence.storageClass=hostpath \
--set sitewhere-infra-core.cp-kafka.persistence.storageClass=hostpath \
--set sitewhere-infra-core.cp-zookeeper.persistence.dataLogDirStorageClass=hostpath \
sitewhere/sitewhere
```

### Developer evironment with `hostpath` storageClass

```console
helm install  sitewhere \
-f ./sitewhere/values-dev.yaml \
--set sitewhere-infra-database.mongodb.persistence.storageClass=hostpath \
--set sitewhere-infra-core.cp-kafka.persistence.storageClass=hostpath \
--set sitewhere-infra-core.cp-zookeeper.persistence.dataLogDirStorageClass=hostpath \
sitewhere/sitewhere
```
