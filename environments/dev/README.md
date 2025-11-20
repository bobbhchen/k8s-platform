# Dev Environment

Configuration files for the development environment deployment.

## Components

- **Cilium**: CNI for networking and network policy
- **Ingress-nginx**: Ingress controller for HTTP routing
- **Prometheus Stack**: Monitoring with Prometheus and Grafana

## Files

- `helmfile.yaml`: Helmfile configuration for orchestrating releases
- `values-cilium.yaml`: Cilium-specific configuration
- `values-ingress-nginx.yaml`: Ingress-nginx-specific configuration
- `values-prometheus.yaml`: Prometheus stack configuration

## Local Deployment with Helmfile

Prerequisites:
- kubectl configured for your dev cluster
- helm 3.x installed
- helmfile installed

### Deploy all components

```bash
cd environments/dev
helmfile apply -e dev
```

### Deploy specific component

```bash
cd environments/dev
helmfile -e dev apply -l name=cilium
helmfile -e dev apply -l name=ingress-nginx
helmfile -e dev apply -l name=prometheus-stack
```

### Sync (update) all components

```bash
cd environments/dev
helmfile sync -e dev
```

### Destroy all components

```bash
cd environments/dev
helmfile destroy -e dev
```

## GitOps Deployment with Argo CD

See `cluster-bootstrap/README.md` for Argo CD deployment instructions.

## Configuration Notes

### Cilium

- CNI mode: standard
- Hubble UI enabled for network observability
- Resources set for dev environment

### Ingress-nginx

- Service type: LoadBalancer
- Metrics enabled with ServiceMonitor for Prometheus
- Resources set for dev environment

### Prometheus Stack

- Retention: 7 days
- Storage: 10Gi persistent volume
- Grafana enabled with ingress at `grafana.dev.example.com`
- Default admin password: `admin-changeme` (should be changed!)

## Customization

To override values:

1. Edit the appropriate `values-*.yaml` file
2. For Helmfile: run `helmfile apply`
3. For Argo CD: commit and push changes, Argo CD will auto-sync
