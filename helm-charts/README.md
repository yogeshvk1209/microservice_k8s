# Helm Charts

This directory contains Helm charts for deploying the microservices infrastructure and applications.

## Structure

```
helm-charts/
├── monitoring/          # Prometheus, Grafana, Metrics Server, Kube State Metrics
├── applications/        # FastAPI, Flask, Jenkins, HTTP services
└── infrastructure/      # Cilium, Cluster Autoscaler, Node Exporter, CoreDNS, Node Local DNS
```

## Quick Start

### Deploy All Charts
```bash
./deploy-helm.sh
```

### Deploy Individual Charts
```bash
# Install monitoring stack
./helm-helper.sh install monitoring

# Upgrade applications
./helm-helper.sh upgrade applications

# Check status
./helm-helper.sh status monitoring

# Template (dry-run)
./helm-helper.sh template infrastructure
```

## Charts Overview

### 1. Monitoring Chart
- **Namespace**: `monitoring`
- **Components**: Prometheus, Grafana, Metrics Server, Kube State Metrics
- **Values**: `helm-charts/monitoring/values.yaml`

### 2. Applications Chart
- **Namespace**: `default`
- **Components**: FastAPI, Flask, Jenkins, HTTP server
- **Values**: `helm-charts/applications/values.yaml`

### 3. Infrastructure Chart
- **Namespace**: `kube-system`
- **Components**: Cilium CNI, Cluster Autoscaler, Node Exporter, CoreDNS, Node Local DNS
- **Values**: `helm-charts/infrastructure/values.yaml`

## Customization

Each chart has a `values.yaml` file that can be customized:

```bash
# Custom values file
helm install monitoring ./helm-charts/monitoring -f my-values.yaml

# Override specific values
helm install monitoring ./helm-charts/monitoring --set prometheus.enabled=false
```

## Useful Commands

```bash
# List all releases
helm list -A

# Get values for a release
helm get values monitoring -n monitoring

# Rollback a release
helm rollback monitoring 1 -n monitoring

# Uninstall all charts
helm uninstall monitoring -n monitoring
helm uninstall applications -n default
helm uninstall infrastructure -n kube-system
```