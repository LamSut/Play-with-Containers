#!/bin/bash

# change the working directory 
cd config

# change Docker daemon to Minikube
eval $(minikube docker-env)

# build Docker images
echo "Building Docker image..."
docker build -t redis:7.0 . || { echo "Failed to build Docker image"; exit 1; }

# deploy with Minikube
echo "Applying Kubernetes deployment..."
minikube kubectl -- apply -f redis-deployment.yaml || { echo "Failed to apply Kubernetes deployment"; exit 1; }

# ensure pods are in running state
echo "Waiting for all pods to be in Running state..."
minikube kubectl -- wait --for=condition=ready pod --all --timeout=300s || { echo "Pods failed to become ready"; exit 1; }

# forward port
echo "Forwarding port..."
minikube kubectl -- port-forward svc/redis 6379:6379 &

# finish
echo "Setup complete! Services can be accessed via the following URL:"
echo "http://localhost:6379"
