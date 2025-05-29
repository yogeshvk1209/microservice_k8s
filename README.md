# Python Microservices with Kubernetes

This project contains three microservices:
1. FastAPI Service (Port 8000)
2. Flask Service (Port 5000)
3. HTTP Static Service (Port 3000)

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
```

## Deploying to Kubernetes
Deploy the services to Kubernetes:

```bash
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

Note: If using minikube, you may need to use `minikube service <service-name>` to access the services.

## Health Checks
- FastAPI Service: `/health`
- Flask Service: `/health`
- HTTP Service: Serves static content only

## Service Information
- FastAPI Service: `/info`
- Flask Service: `/info`
- HTTP Service: Static webpage with version information

## License
This project is licensed under the MIT License!!! Enjoy!!!
