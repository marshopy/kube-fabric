#!/bin/bash
PROJECTDIR=$(dirname $0)

echo "Deleting Existing pods"
kubectl delete -f ${PROJECTDIR}/kube_configs/setup_network.yaml

while [ "$(kubectl get pods | grep fabricnetwork | wc -l | awk '{print $1}')" != "0" ]; do
	echo "Waiting for old pod to be deleted"
	sleep 1;
done

kubectl create -f ${PROJECTDIR}/kube_configs/setup_network.yaml

