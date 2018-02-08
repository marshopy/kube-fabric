#!/bin/bash

PROJECTDIR=$(dirname $0)

echo "Deleting Existing Deployment"
kubectl delete -f ${PROJECTDIR}/kube_configs/platform
kubectl delete -f ${PROJECTDIR}/kube_configs/blockchain
kubectl delete -f ${PROJECTDIR}/kube_configs/bootstrap

