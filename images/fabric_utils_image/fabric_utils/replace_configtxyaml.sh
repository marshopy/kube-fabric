#!/bin/bash
CURRENT_DIR=$(dirname $0)

cp ${CURRENT_DIR}/configtx.yaml.base /var/tmp/configtx.yaml.tmp
sed -i "s/orderer0:7050/${ORDERER_URL}/g" /var/tmp/configtx.yaml.tmp
#sleep 1
sed -i "s/PEERHOST1/${PEERHOST1}/g" /var/tmp/configtx.yaml.tmp
#sleep 1
sed -i "s/PEERPORT1/${PEERPORT1}/g" /var/tmp/configtx.yaml.tmp
#sleep 1
sed -i "s/PEERHOST2/${PEERHOST2}/g" /var/tmp/configtx.yaml.tmp
#sleep 1
sed -i "s/PEERPORT2/${PEERPORT2}/g" /var/tmp/configtx.yaml.tmp
#sleep 1
mv /var/tmp/configtx.yaml.tmp ${CURRENT_DIR}/configtx.yaml

