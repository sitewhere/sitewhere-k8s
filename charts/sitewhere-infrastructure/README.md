# SiteWhere Infrastructure Helm Chart

This Chart installs SiteWhere 3.0 Infrastructure.

## Prerequisites

- Kubernetes cluster 1.10+
- Helm 3.0.0+
- PV provisioner support in the underlying infrastructure.

## TL;DR

```console
helm repo add sitewhere https://sitewhere.io/helm-charts
helm install sitewhere -n sitewhere-system --create-namespace sitewhere/sitewhere-infrastructure
```
