# Helm Charts for Deploying SiteWhere 3.0
SiteWhere provides two Helm charts which support deployment of both the infrastructure required
to run SiteWhere and the microservices which take care of the actual processing. The infrastructure
chart is generally deployed once when a cluster is first created and only changed when components in
the infrastructure need to be scaled or reconfigured. The chart for microservices is executed once
per instance deployed and may be deleted without shutting down the infrastructure chart.

## Prerequisites
There are a few components which must be installed before deploying SiteWhere via Helm. Start
by cloning the k8s charts repository using the following command:

```console
git clone https://github.com/sitewhere/sitewhere-k8s.git
```

Make sure that Helm is installed and open a command line in the `charts` subfolder.

### Install SiteWhere Custom Resource Definitions
In order to prepare the system for running SiteWhere instances, the SiteWhere custom resource definitions 
must be installed. Install the CRDs via Helm using the following command:

```console
helm install --name sitewhere-crds crds/.
```

### Install Default Instance and Tenant Templates
In order to bootstrap an instance, default instance and tenant templates must
be installed. These templates determine the default system configuration and
may be customized before/after installation. The command below will install the 
default templates:

```console
helm install --name sitewhere-templates templates/.
```

### Install SiteWhere Operator
The SiteWhere operator is an orchestrator which uses the CRDs and templates to realize 
SiteWhere instances at runtime. The operator translates SiteWhere CRDs into Kubernetes
resources and monitors the runtime in order to match the desired state. Install the operator
via Helm as shown below:

```console
helm install --name sitewhere-operator operator/.
```
### Istio Service Mesh
SiteWhere 3.0 requires [Istio](https://istio.io/), with 
[Automatic sidecar injection](https://istio.io/docs/setup/kubernetes/additional-setup/sidecar-injection/#automatic-sidecar-injection),
installed on a Kubernetes cluster before you deploy an instance of SiteWhere. You can install Istio
[with](https://istio.io/docs/setup/kubernetes/install/helm/) or [without](https://istio.io/docs/setup/kubernetes/install/kubernetes/) Helm.

Make sure that the namespace where you are deploying SiteWhere has the label `istio-injection=enabled`, 
for example for the `default` namespace use:

```console
kubectl get namespace -L istio-injection
```

```
NAME           STATUS    AGE       ISTIO-INJECTION
default        Active    1h        enabled
istio-system   Active    1h
kube-public    Active    1h
kube-system    Active    1h
```

If not, add the label to the namespace:

```console
kubectl label namespace default istio-injection=enabled
```

## Deploy SiteWhere Infrastructure Components

To start the infrastructure components with default settings, execute the following:

```console
helm install --name sitewhere sitewhere/sitewhere-infrastructure
```
or from a cloned repository execute:

```console
cd sitewhere-k8s/charts/sitewhere-infrastructure
helm install --name sitewhere-infrastructure .
```

## Deploy SiteWhere Microservices

Once the infrastructure components have started, the SiteWhere microservices
may be deployed by executing:

```console
helm install --name sitewhere sitewhere/sitewhere
```
or from a cloned repository execute:

```console
cd sitewhere-k8s/charts/sitewhere
helm install --name sitewhere .
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
kubectl create -f ../rook/common.yaml
kubectl create -f ../rook/operator.yaml
kubectl create -f ../rook/cluster-test.yaml
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
--set sitewhere-infra-core.cp-kafka.persistence.storageClass=<your-storage-class> \
--set sitewhere-infra-core.cp-zookeeper.persistence.dataLogDirStorageClass=<your-storage-class> \
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
this [document](https://rook.io/docs/rook/v1.0/ceph-teardown.html)
on how to uninstall Rook.io from Kuberntes.
