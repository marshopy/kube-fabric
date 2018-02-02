#!/bin/bash
PROJECTDIR=$(dirname $0)

if [ -z ${PRIVATEIP} ]; then 
	export PRIVATEIP=$(bx cs workers blockchain | grep free | awk '{print $2}')
fi

echo "IP = ${PRIVATEIP}"

sed "s/%PRIVATEIP%/${PRIVATEIP}/g" ${PROJECTDIR}/kube_configs/template/join_channel.yaml.base > ${PROJECTDIR}/kube_configs/join_channel.yaml

echo "Deleting Existing pods"
kubectl delete -f ${PROJECTDIR}/kube_configs/join_channel.yaml

while [ "$(kubectl get pods | grep joinchannel | wc -l | awk '{print $1}')" != "0" ]; do
	echo "Waiting for old pod to be deleted"
	sleep 1;
done

echo "Creating joinchannel pod"
kubectl create -f ${PROJECTDIR}/kube_configs/join_channel.yaml


