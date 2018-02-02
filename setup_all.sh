#!/bin/bash
PROJECTDIR=$(dirname $0)

if [ -z ${PRIVATEIP} ]; then 
	export PRIVATEIP=$(bx cs workers blockchain | grep free | awk '{print $2}')
fi

echo "IP = ${PRIVATEIP}"

sed "s/%PRIVATEIP%/${PRIVATEIP}/g" ${PROJECTDIR}/kube_configs/template/blockchain.yaml.base > ${PROJECTDIR}/kube_configs/blockchain.yaml
sed "s/%PRIVATEIP%/${PRIVATEIP}/g" ${PROJECTDIR}/kube_configs/template/create_channel.yaml.base > ${PROJECTDIR}/kube_configs/create_channel.yaml
sed "s/%PRIVATEIP%/${PRIVATEIP}/g" ${PROJECTDIR}/kube_configs/templatejoin_channel.yaml.base > ${PROJECTDIR}/kube_configs/join_channel.yaml
sed "s/%PRIVATEIP%/${PRIVATEIP}/g" ${PROJECTDIR}/kube_configs/template/composer-playground.yaml.base > ${PROJECTDIR}/kube_configs/composer-playground.yaml
# composer-rest-server not here as it requires user to deploy a business network

echo "Deleting Existing pods"
kubectl delete -f ${PROJECTDIR}/kube_configs/blockchain.yaml
kubectl delete -f ${PROJECTDIR}/kube_configs/create_channel.yaml
kubectl delete -f ${PROJECTDIR}/kube_configs/join_channel.yaml
kubectl delete -f ${PROJECTDIR}/kube_configs/composer-playground.yaml
# composer-rest-server not here as it requires user to deploy a business network

while [ "$(kubectl get pods | wc -l | awk '{print $1}')" != "0" ]; do
	echo "Waiting for old pod to be deleted"
	sleep 1;
done

echo "Creating new Deployment"
kubectl create -f ${PROJECTDIR}/kube_configs/blockchain.yaml

echo "Hold on${PROJECTDIR}."
sleep 5

while [ "$(kubectl get pods | grep Creat | wc -l | awk '{print $1}')" != "0" ]; do
	echo "Waiting for new containers to be created"
	sleep 1;
done

kubectl create -f ${PROJECTDIR}/kube_configs/create_channel.yaml
sleep 30
kubectl create -f ${PROJECTDIR}/kube_configs/join_channel.yaml
sleep 30
kubectl create -f ${PROJECTDIR}/kube_configs/composer-playground.yaml
# composer-rest-server not here as it requires user to deploy a business network

