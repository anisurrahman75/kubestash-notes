#!/bin/bash

# Define the repository directory
REPO_DIR="/root/external-snapshotter"

# Echo the directory being used
echo "Installing VS from Dir=${REPO_DIR}"

# Ensure the directory exists or clone if it does not
if [ ! -d "${REPO_DIR}" ]; then
    echo "Cloning repository..."
    git clone https://github.com/kubernetes-csi/external-snapshotter.git "${REPO_DIR}"
else
    echo "Repository directory exists. Pulling latest changes..."
    cd "${REPO_DIR}" && git pull
fi

# Change to the repository directory
cd "${REPO_DIR}"

# Apply Kubernetes configurations and install Longhorn
echo "Applying Kubernetes configurations..."
kubectl kustomize client/config/crd | kubectl create -f -
kubectl -n kube-system kustomize deploy/kubernetes/snapshot-controller | kubectl create -f -
kubectl kustomize deploy/kubernetes/csi-snapshotter | kubectl create -f -

echo "Installing Longhorn..."
helm repo add longhorn https://charts.longhorn.io
helm repo update
helm install longhorn longhorn/longhorn --namespace longhorn-system --create-namespace --version 1.6.2

echo "Installation completed."