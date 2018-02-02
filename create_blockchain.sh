#!/bin/bash
PROJECTDIR=$(dirname $0)

if [ -z ${PRIVATEIP} ]; then 
	export PRIVATEIP=$(bx cs workers blockchain | grep free | awk '{print $2}')
fi

echo "IP = ${PRIVATEIP}"

sed "s/%PRIVATEIP%/${PRIVATEIP}/g" ${PROJECTDIR}/kube_configs/template/blockchain.yaml.base > ${PROJECTDIR}/kube_configs/blockchain.yaml

echo "Creating new Deployment"
kubectl create -f ${PROJECTDIR}/kube_configs/blockchain.yaml 

