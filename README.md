# Python Microservices with Kubernetes

This project contains three microservices, Jenkins CI/CD, and comprehensive monitoring setup:
1. FastAPI Service (Port 8000)
2. Flask Service (Port 5000)
3. HTTP Static Service (Port 3000)
4. Jenkins CI/CD Server (Port 8080)
5. Prometheus Monitoring (Port 9090)
6. Grafana Dashboards (Port 3000)
7. Node Exporter (Port 9100)
8. Kube State Metrics (Port 8080)

## Prerequisites

- Docker
- Kubernetes cluster (minikube or similar)
- kubectl

## Building the Services
Build the Docker images for each service:

```bash
# Build FastAPI Service
cd services/fastapi_service
docker build -t fastapi-service .

# Build Flask Service
cd ../flask_service
docker build -t flask-service .

# Build HTTP Service
cd ../http_service
docker build -t http-service .

# Build Jenkins
cd ../../jenkins
docker build -t jenkins-custom .
```

## Deploying to Kubernetes
Deploy the services to Kubernetes:

```bash
# Create Jenkins PV and PVC
kubectl apply -f k8s/jenkins-pv.yaml

# Apply all deployments and services
kubectl apply -f k8s/

# Verify deployments
kubectl get deployments
kubectl get pods
kubectl get services
```

## Accessing the Services
After deployment, you can access the services through their respective LoadBalancer services:

- FastAPI Service: http://localhost:80 (forwarded to port 8000)
- Flask Service: http://localhost:80 (forwarded to port 5000)
- HTTP Static Service: http://localhost:80 (forwarded to port 3000)
- Jenkins: http://localhost:8080 (admin interface)

### Monitoring Services
Access monitoring services using port forwarding:

```bash
# Access Prometheus
kubectl port-forward service/prometheus 9090:9090
# Then visit: http://localhost:9090

# Access Grafana
kubectl port-forward service/grafana 3000:3000
# Then visit: http://localhost:3000 (admin/admin123)

# Access Node Exporter metrics (optional)
kubectl port-forward service/node-exporter 9100:9100
# Then visit: http://localhost:9100/metrics

# Access Kube State Metrics (optional)
kubectl port-forward service/kube-state-metrics 8080:8080
# Then visit: http://localhost:8080/metrics
```

Note: If using minikube, you may need to use `minikube service <service-name>` to access the services.

## Health Checks
- FastAPI Service: `/health`
- Flask Service: `/health`
- HTTP Service: Serves static content only
- Jenkins: `/login` (health check endpoint)

## Service Information
- FastAPI Service: `/info`
- Flask Service: `/info`
- HTTP Service: Static webpage with version information
- Jenkins: Accessible via BlueOcean interface at `/blue`

## Monitoring Stack

This project includes a comprehensive monitoring setup with Prometheus, Grafana, Node Exporter, and Kube State Metrics.

### Components

**Prometheus** - Metrics collection and storage
- Scrapes metrics from all services and Kubernetes components
- Configured with service discovery for automatic target detection
- Includes alerting capabilities

**Grafana** - Visualization and dashboards
- Pre-configured with Prometheus as data source
- Ready for dashboard imports and custom visualizations
- Default credentials: `admin/admin123`

**Node Exporter** - Host-level metrics
- Deployed as DaemonSet on all nodes
- Collects CPU, memory, disk, and network metrics
- Provides hardware and OS-level monitoring

**Kube State Metrics** - Kubernetes object metrics
- Monitors Kubernetes API objects (pods, deployments, services, etc.)
- Provides cluster-level insights and resource utilization
- Essential for Kubernetes-specific dashboards

### Popular Grafana Dashboards

After accessing Grafana, import these dashboard IDs for instant monitoring:

```bash
# In Grafana: Dashboards → Import → Enter ID
```

- **Node Exporter Full**: `1860` - Comprehensive host metrics
- **Kubernetes Cluster Monitoring**: `315` - Overall cluster health
- **Kube State Metrics**: `13332` - Kubernetes object monitoring
- **Prometheus Stats**: `2` - Prometheus server metrics

### Monitoring Features

- **Automatic Service Discovery**: Prometheus automatically discovers and monitors new services
- **Pod Annotation Support**: Add `prometheus.io/scrape: "true"` to pod annotations for custom metrics
- **RBAC Configured**: Proper permissions for cluster-wide monitoring
- **Persistent Storage**: Metrics data persists across pod restarts
- **Health Checks**: All monitoring components include readiness and liveness probes

## Jenkins Setup
The Jenkins installation comes with the following features:
- Pre-installed essential plugins (Git, GitHub, Docker, Kubernetes, etc.)
- Blue Ocean interface for modern CI/CD pipeline visualization
- Docker CLI support for container builds
- Kubernetes plugin for cloud-native CI/CD
- Persistent volume for maintaining configuration and build history
- JNLP port (50000) for Jenkins agents

Initial access:
1. Get the initial admin password:
```bash
kubectl exec -it $(kubectl get pods -l app=jenkins -o jsonpath='{.items[0].metadata.name}') -- cat /var/jenkins_home/secrets/initialAdminPassword
```
2. Navigate to http://localhost:8080
3. Use the password obtained in step 1
4. Jenkins is pre-configured to skip the initial setup wizard

## License
This project is licensed under the MIT License!!! Enjoy!!!
