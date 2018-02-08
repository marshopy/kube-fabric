#!/usr/bin/env bash

ORDERER_URL=orderer.ordererorg1:7050
ORG1_PEER1_URL=peer1.peerorg1:7051
ORG1_PEER2_URL=peer2.peerorg1:8051
ORG2_PEER1_URL=peer1.peerorg2:9051
ORG2_PEER2_URL=peer2.peerorg2:10051

for url in ${ORDERER_URL} ${ORG1_PEER1_URL} ${ORG1_PEER2_URL} ${ORG2_PEER1_URL} ${ORG2_PEER2_URL}; do
    curl ${url} || exit 255
done
exit 0