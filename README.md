# k8s-platform

GitOps platform for Kubernetes infrastructure management using Helmfile and Argo CD.

## Structure

```
k8s-platform/
├── cluster-bootstrap/     # Argo CD Application manifests
├── charts/               # Helm wrapper charts
│   ├── common/          # Library chart with shared helpers
│   ├── cilium/          # Cilium CNI wrapper
│   ├── ingress-nginx/   # Ingress-nginx controller wrapper
│   ├── prometheus-stack/ # Prometheus + Grafana wrapper
│   └── dashboards/      # Dashboard configurations
│       └── grafana/     # Standalone Grafana wrapper
└── environments/        # Environment-specific configurations
    └── dev/            # Dev environment
        ├── helmfile.yaml
        ├── values-cilium.yaml
        ├── values-ingress-nginx.yaml
        └── values-prometheus.yaml
```

## Components

### Dev Environment

The dev environment includes:
- **Cilium**: CNI for networking and network policy
- **Ingress-nginx**: Ingress controller for HTTP routing
- **Prometheus Stack**: Monitoring with Prometheus and Grafana

### Local Development

Apply the dev environment using Helmfile:

```bash
cd environments/dev
helmfile apply -e dev
```

### GitOps with Argo CD

The dev environment can be managed by Argo CD using the Application manifest:

```bash
kubectl apply -f cluster-bootstrap/argocd-app-dev.yaml
```

## Getting Started

1. Install prerequisites:
   - kubectl
   - helm 3.x
   - helmfile (optional, for local development)

2. Deploy to dev environment:
   ```bash
   cd environments/dev
   helmfile apply -e dev
   ```

3. Or use Argo CD for GitOps:
   ```bash
   kubectl apply -f cluster-bootstrap/argocd-app-dev.yaml
   ```