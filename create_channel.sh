#!/bin/bash
PROJECTDIR=$(dirname $0)

if [ -z ${PRIVATEIP} ]; then 
	export PRIVATEIP=$(bx cs workers blockchain | grep free | awk '{print $2}')
fi

echo "IP = ${PRIVATEIP}"

sed "s/%PRIVATEIP%/${PRIVATEIP}/g" ${PROJECTDIR}/kube_configs/template/create_channel.yaml.base > ${PROJECTDIR}/kube_configs/create_channel.yaml

echo "Deleting Existing pods"
kubectl delete -f ${PROJECTDIR}/kube_configs/create_channel.yaml

while [ "$(kubectl get pods | grep createchannel | wc -l | awk '{print $1}')" != "0" ]; do
	echo "Waiting for old pod to be deleted"
	sleep 1;
done

kubectl create -f ${PROJECTDIR}/kube_configs/create_channel.yaml

