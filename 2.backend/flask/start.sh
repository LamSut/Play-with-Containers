#!/bin/bash

# change Docker daemon to Minikube
eval $(minikube docker-env)

# define variables
REPO_URL="https://github.com/LamSut/cicd_tutorial"
REPO_DIR="repo"
CONFIG_FILES="./config/*"

# clone repository
if [ -d "$REPO_DIR" ]; then
  echo "Repository directory $REPO_DIR already exists. Skipping clone."
else
  echo "Cloning the repository..."
  git clone $REPO_URL $REPO_DIR || { echo "Failed to clone repository"; exit 1; }
fi

# copy config files
echo "Copying configuration files..."
cp $CONFIG_FILES $REPO_DIR || { echo "Failed to copy config files"; exit 1; }

# change to repository directory
echo "Changing to repository directory..."
cd $REPO_DIR || { echo "Failed to enter $REPO_DIR"; exit 1; }

# build Docker images
echo "Building Docker image..."
docker build -t flask:v1 . || { echo "Failed to build Docker image"; exit 1; }

# deploy with Minikube
echo "Applying Kubernetes deployment..."
minikube kubectl -- apply -f flask-deployment.yaml || { echo "Failed to apply Kubernetes deployment"; exit 1; }

# ensure pods are in running state
echo "Waiting for all pods to be in Running state..."
minikube kubectl -- wait --for=condition=ready pod --all --timeout=300s || { echo "Pods failed to become ready"; exit 1; }

# forward ports
echo "Forwarding port..."
minikube kubectl -- port-forward svc/flask-service 5000:5000 &

# finish
echo "Setup complete! Services can be accessed via the following URL:"
echo "http://localhost:6969"
