# Charts Directory

This directory contains Helm charts for the k8s-platform project. All charts here are **wrapper charts** that depend on upstream Helm charts from official repositories.

## Structure

- **common/**: Library chart providing shared helpers and templates (labels, ingress, etc.)
- **cilium/**: Wrapper for Cilium CNI
- **ingress-nginx/**: Wrapper for ingress-nginx controller
- **prometheus-stack/**: Wrapper for kube-prometheus-stack (Prometheus + Grafana)
- **dashboards/grafana/**: Wrapper for standalone Grafana (when more configuration is needed beyond kube-prometheus-stack)

## Usage

These wrapper charts allow us to:
1. Pin specific upstream chart versions
2. Provide environment-specific default values
3. Maintain consistency across deployments
4. Easily upgrade or rollback versions

## Updating Dependencies

To update chart dependencies after modifying `Chart.yaml`:

```bash
cd charts/<chart-name>
helm dependency update
```

## Local Development

You can test these charts locally using Helm:

```bash
helm template my-release ./charts/cilium -f environments/dev/values-cilium.yaml
```

Or use Helmfile for a complete environment deployment:

```bash
cd environments/dev
helmfile apply -e dev
```
