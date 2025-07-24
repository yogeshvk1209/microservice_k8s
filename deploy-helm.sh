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

# Deploy infrastructure components first
echo "🏗️  Deploying infrastructure components..."
helm upgrade --install infrastructure ./helm-charts/infrastructure \
    --namespace kube-system \
    --create-namespace

# Deploy networking components
echo "🌐 Deploying networking components..."
helm upgrade --install networking ./helm-charts/networking \
    --namespace kube-system

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
echo "  - Infrastructure: helm-charts/infrastructure"
echo "  - Networking: helm-charts/networking"
echo "  - Monitoring: helm-charts/monitoring"
echo "  - Applications: helm-charts/applications"
echo ""
echo "🔍 Check deployment status:"
echo "  helm list -A"
echo "  kubectl get pods -A"