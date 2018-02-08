#!/bin/bash
PROJECTDIR=$(dirname $0)

echo "Creating new Deployment"
kubectl create -f ${PROJECTDIR}/kube_configs/bootstrap
kubectl create -f ${PROJECTDIR}/kube_configs/blockchain
kubectl create -f ${PROJECTDIR}/kube_configs/platform

# composer-rest-server not here as it requires user to deploy a business network

