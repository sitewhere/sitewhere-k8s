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
helm install --namespace sitewhere-system --name sitewhere-operator operator/.
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
helm install --namespace sitewhere-system --name sitewhere sitewhere/sitewhere-infrastructure
```
or from a cloned repository execute:

```console
cd sitewhere-k8s/charts/sitewhere-infrastructure
helm install --namespace sitewhere-system --name sitewhere-infrastructure .
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

## Steps to install from Repository (WIP)

1 - Install Istio Service Mesh with Sidecar Injection Enabled

2 - 

```console
kubectl create namespace sitewhere
kubectl label namespace sitewhere istio-injection=enabled

helm install --name sitewhere-crds crds/.
helm install --name sitewhere-templates templates/.
helm install --namespace sitewhere-system --name sitewhere-operator operator/.

helm repo add cetic https://cetic.github.io/helm-charts
helm repo update
helm dep update sitewhere-infrastructure/

helm install --namespace sitewhere-system --name sitewhere-infrastructure ./sitewhere-infrastructure

helm install --name sitewhere ./sitewhere
```
