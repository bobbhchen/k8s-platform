# Cluster Bootstrap

This directory contains Argo CD Application manifests for bootstrapping the k8s-platform components.

## Dev Environment

The `argocd-app-dev.yaml` file contains Argo CD Application resources for deploying the dev environment components:

- **dev-cilium**: Cilium CNI in the `kube-system` namespace
- **dev-ingress-nginx**: Ingress-nginx controller in the `ingress-nginx` namespace
- **dev-prometheus-stack**: Prometheus + Grafana in the `observability` namespace

## Prerequisites

1. A Kubernetes cluster
2. Argo CD installed in the `argocd` namespace

Install Argo CD:

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

## Usage

Apply the dev environment Applications:

```bash
kubectl apply -f cluster-bootstrap/argocd-app-dev.yaml
```

Check the status:

```bash
kubectl get applications -n argocd
```

View details:

```bash
kubectl describe application dev-cilium -n argocd
```

## Sync Policy

All applications are configured with automated sync:
- **prune**: Automatically remove resources that are no longer defined
- **selfHeal**: Automatically sync when cluster state deviates from Git
- **CreateNamespace**: Automatically create target namespaces if they don't exist

## Notes

- These applications pull from the `main` branch
- Environment-specific values are loaded from `environments/dev/`
- Dependencies between components are managed by Argo CD sync waves (if needed in the future)
