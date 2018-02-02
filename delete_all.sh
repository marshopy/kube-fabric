#!/bin/bash

PROJECTDIR=$(dirname $0)

if [ -z ${PRIVATEIP} ]; then 
	export PRIVATEIP=$(bx cs workers blockchain | grep free | awk '{print $2}')
fi

echo "IP = ${PRIVATEIP}"

sed "s/%PRIVATEIP%/${PRIVATEIP}/g" ${PROJECTDIR}/kube_configs/template/blockchain.yaml.base > ${PROJECTDIR}/kube_configs/blockchain.yaml
sed "s/%PRIVATEIP%/${PRIVATEIP}/g" ${PROJECTDIR}/kube_configs/template/create_channel.yaml.base > ${PROJECTDIR}/kube_configs/create_channel.yaml
sed "s/%PRIVATEIP%/${PRIVATEIP}/g" ${PROJECTDIR}/kube_configs/template/join_channel.yaml.base > ${PROJECTDIR}/kube_configs/join_channel.yaml
sed "s/%PRIVATEIP%/${PRIVATEIP}/g" ${PROJECTDIR}/kube_configs/template/composer-playground.yaml.base > ${PROJECTDIR}/kube_configs/composer-playground.yaml
sed "s/%PRIVATEIP%/${PRIVATEIP}/g" ${PROJECTDIR}/kube_configs/template/composer-rest-server.yaml.base > ${PROJECTDIR}/kube_configs/composer-rest-server.yaml

echo "Deleting Existing pods"
kubectl delete -f ${PROJECTDIR}/kube_configs/blockchain.yaml
kubectl delete -f ${PROJECTDIR}/kube_configs/create_channel.yaml
kubectl delete -f ${PROJECTDIR}/kube_configs/join_channel.yaml
kubectl delete -f ${PROJECTDIR}/kube_configs/composer-playground.yaml
kubectl delete -f ${PROJECTDIR}/kube_configs/composer-rest-server.yaml

while [ "$(kubectl get pods | wc -l | awk '{print $1}')" != "0" ]; do
	echo "Waiting for all old pods to be deleted"
	sleep 1;
done

