# Python Microservices with Kubernetes

This project contains three microservices and a Jenkins CI/CD setup:
1. FastAPI Service (Port 8000)
2. Flask Service (Port 5000)
3. HTTP Static Service (Port 3000)
4. Jenkins CI/CD Server (Port 8080)

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
