#!/bin/bash

# Script to deploy all Helm charts
# Author: Kiro
# Date: 17/07/2025

set -e  # Exit immediately if a command exits with a non-zero status

echo "🚀 Deploying Helm charts..."

# Check if Helm is installed
if ! command -v helm &> /dev/null; then
    echo "❌ Helm is not installed. Please install Helm first."
    exit 1
fi

# Deploy infrastructure components first (includes networking)
echo "🏗️  Deploying infrastructure components..."
helm upgrade --install infrastructure ./helm-charts/infrastructure \
    --namespace kube-system \
    --create-namespace

# Deploy monitoring stack
echo "📊 Deploying monitoring stack..."
helm upgrade --install monitoring ./helm-charts/monitoring \
    --namespace monitoring \
    --create-namespace

# Deploy applications
echo "🚀 Deploying applications..."
helm upgrade --install applications ./helm-charts/applications \
    --namespace default

echo "✅ All Helm charts deployed successfully!"
echo ""
echo "📋 Deployment Summary:"
echo "  - Infrastructure: helm-charts/infrastructure (Cilium, Cluster Autoscaler, Node Exporter, CoreDNS, Node Local DNS)"
echo "  - Monitoring: helm-charts/monitoring (Prometheus, Grafana, Metrics Server)"
echo "  - Applications: helm-charts/applications (FastAPI, Flask, Jenkins, HTTP)"
echo ""
echo "🔍 Check deployment status:"
echo "  helm list -A"
echo "  kubectl get pods -A"