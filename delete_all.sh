#!/bin/bash

PROJECTDIR=$(dirname $0)

echo "Deleting Existing pods"
kubectl delete -f ${PROJECTDIR}/kube_configs/setup_network.yaml
kubectl delete -f ${PROJECTDIR}/kube_configs/blockchain.yaml
kubectl delete -f ${PROJECTDIR}/kube_configs/kubernetes_fabric_utils.yaml
kubectl delete -f ${PROJECTDIR}/kube_configs/fabric_namespace.yaml
kubectl delete -f ${PROJECTDIR}/kube_configs/composer-playground.yaml
kubectl delete -f ${PROJECTDIR}/kube_configs/composer-rest-server.yaml

while [ "$(kubectl get pods | wc -l | awk '{print $1}')" != "0" ]; do
	echo "Waiting for all old pods to be deleted"
	sleep 1;
done

