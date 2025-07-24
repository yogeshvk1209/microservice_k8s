#!/bin/bash

# Helm Helper Script
# Usage: ./helm-helper.sh [install|upgrade|uninstall|status] [chart-name]

set -e

CHART_NAME=$2
ACTION=$1

case $CHART_NAME in
    "monitoring")
        NAMESPACE="monitoring"
        CHART_PATH="./helm-charts/monitoring"
        ;;
    "applications")
        NAMESPACE="default"
        CHART_PATH="./helm-charts/applications"
        ;;
    "infrastructure")
        NAMESPACE="kube-system"
        CHART_PATH="./helm-charts/infrastructure"
        ;;
    *)
        echo "❌ Unknown chart: $CHART_NAME"
        echo "Available charts: monitoring, applications, infrastructure"
        exit 1
        ;;
esac

case $ACTION in
    "install")
        echo "📦 Installing $CHART_NAME chart..."
        helm install $CHART_NAME $CHART_PATH --namespace $NAMESPACE --create-namespace
        ;;
    "upgrade")
        echo "⬆️  Upgrading $CHART_NAME chart..."
        helm upgrade $CHART_NAME $CHART_PATH --namespace $NAMESPACE
        ;;
    "uninstall")
        echo "🗑️  Uninstalling $CHART_NAME chart..."
        helm uninstall $CHART_NAME --namespace $NAMESPACE
        ;;
    "status")
        echo "📊 Status of $CHART_NAME chart..."
        helm status $CHART_NAME --namespace $NAMESPACE
        ;;
    "template")
        echo "📋 Templating $CHART_NAME chart..."
        helm template $CHART_NAME $CHART_PATH --namespace $NAMESPACE
        ;;
    *)
        echo "❌ Unknown action: $ACTION"
        echo "Available actions: install, upgrade, uninstall, status, template"
        exit 1
        ;;
esac