#!/bin/bash
PROJECTDIR=$(dirname $0)

echo "Creating new Deployment"
kubectl create -f ${PROJECTDIR}/kube_configs/fabric_namespace.yaml
kubectl create -f ${PROJECTDIR}/kube_configs/kubernetes_fabric_utils.yaml
kubectl create -f ${PROJECTDIR}/kube_configs/blockchain.yaml

