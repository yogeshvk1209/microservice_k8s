#!/bin/bash

# Script to apply all Kubernetes manifests in the k8s directory
# Author: Kiro
# Date: 17/07/2025

set -e  # Exit immediately if a command exits with a non-zero status

echo "🚀 Applying Kubernetes manifests..."

# Apply core infrastructure components first
echo "📦 Applying CNI (Cilium)..."
kubectl apply -f k8s/cilium-deployment.yaml

echo "📦 Applying DNS components..."
kubectl apply -f k8s/coredns-deployment.yaml
kubectl apply -f k8s/node-local-dns-deployment.yaml

echo "📦 Applying metrics and monitoring components..."
kubectl apply -f k8s/metrics-server-deployment.yaml
kubectl apply -f k8s/node-exporter-deployment.yaml

echo "📦 Applying cluster management components..."
kubectl apply -f k8s/cluster-autoscaler-deployment.yaml

# Apply Prometheus and related components
echo "📊 Applying monitoring stack..."
kubectl apply -f k8s/prometheus-configmap.yaml
kubectl apply -f k8s/prometheus-deployment.yaml
kubectl apply -f k8s/grafana-deployment.yaml

# Apply application deployments
echo "🌐 Applying application deployments..."
kubectl apply -f k8s/fastapi-deployment.yaml
kubectl apply -f k8s/flask-deployment.yaml
kubectl apply -f k8s/http-deployment.yaml

# Apply CI/CD components
echo "🔄 Applying CI/CD components..."
kubectl apply -f k8s/jenkins-pv.yaml
kubectl apply -f k8s/jenkins-deployment.yaml

echo "✅ All Kubernetes manifests applied successfully!"
echo "Use 'kubectl get pods -A' to check the status of all pods."