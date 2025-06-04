# Jenkins CICD Pipeline

This folder contains Jenkins pipeline configuration for automating the build and deployment process of Docker images.

## Pipeline Overview

The pipeline performs the following tasks:
1. Clones a Git repository
2. Builds a Docker image from a specified Dockerfile
3. Pushes the image to DockerHub

## Prerequisites

1. Jenkins server with following plugins installed:
   - Docker Pipeline
   - Git
   - Credentials Plugin

2. Docker installed on the Jenkins agent
3. DockerHub account and credentials

## Setup Instructions

1. In Jenkins, navigate to "Manage Jenkins" > "Manage Credentials"
2. Add your DockerHub credentials:
   - Kind: Username with password
   - Scope: Global
   - ID: dockerhub-credentials
   - Description: DockerHub Credentials
   - Username: Your DockerHub username
   - Password: Your DockerHub password/token

## Pipeline Parameters

The pipeline accepts the following parameters:
- `GIT_REPO_URL`: URL of the Git repository to clone
- `GIT_BRANCH`: Branch to build (default: main)
- `DOCKERFILE_PATH`: Path to the Dockerfile in the repository
- `IMAGE_NAME`: Name for the Docker image
- `IMAGE_TAG`: Tag for the Docker image (default: latest)

## Usage

1. Create a new Pipeline job in Jenkins
2. Configure the pipeline to use this Jenkinsfile
3. Run the pipeline with desired parameters

## Example Usage

```groovy
// Example pipeline run with custom parameters
pipeline {
    agent any
    parameters {
        string(name: 'GIT_REPO_URL', defaultValue: 'https://github.com/yourusername/microservice_k8s.git')
        string(name: 'DOCKERFILE_PATH', defaultValue: 'jenkins/Dockerfile')
        string(name: 'IMAGE_NAME', defaultValue: 'jenkins2.504_jdk21')
        string(name: 'IMAGE_TAG', defaultValue: 'v1.0')
    }
    // ... rest of the pipeline
}
```

## Security Notes

1. Never commit sensitive credentials to the repository
2. Use Jenkins credentials store for all sensitive information
3. Consider using Docker registry authentication tokens instead of passwords
4. Ensure proper access controls on Jenkins 