#!/bin/bash
PROJECTDIR=$(dirname $0)
INSTALL_MODE="$1"
CHAINCODE_ENABLED="$2"

if [ ${INSTALL_MODE} == "INSTALL" ]; then
    echo "Creating new Deployment"
    kubectl create -f ${PROJECTDIR}/kube_configs/bootstrap
    kubectl create -f ${PROJECTDIR}/kube_configs/blockchain

    if [ "${CHAINCODE_ENABLED}" == "true" ]; then
        echo "Waiting for 1 minute before doing end to end test"
        sleep 60
        kubectl create -f ${PROJECTDIR}/kube_configs/chaincode
    else
        echo "Waiting for 1 minute before setting up the platform"
        sleep 60
        kubectl create -f ${PROJECTDIR}/kube_configs/platform
    fi
elif [ ${INSTALL_MODE} == "UNINSTALL" ]; then
    echo "Deleting Existing Deployment"
    if [ "${CHAINCODE_ENABLED}" == "true" ]; then
        kubectl delete -f ${PROJECTDIR}/kube_configs/chaincode
    else
        kubectl delete -f ${PROJECTDIR}/kube_configs/platform
    fi
    kubectl delete -f ${PROJECTDIR}/kube_configs/blockchain
    kubectl delete -f ${PROJECTDIR}/kube_configs/bootstrap
else
    echo "Failed to build fabric network in Kubernetes. Need to specify install mode either INSTALL or UNINSTALL"
    exit 255
fi