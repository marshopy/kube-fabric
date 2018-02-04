#! /bin/bash

CURRENT_DIR=$(dirname $0)

echo "Deleting old stuff"
rm -rf /shared/*
rm -rf /shared/utils
rm -rf /utils/orderer.block

echo "Pulling chain code environment container"
docker pull hyperledger/fabric-ccenv:x86_64-1.0.5

echo "Generating crypto material"
${CURRENT_DIR}/generate_crypto.sh

echo "Generating genesis block"
${CURRENT_DIR}/generate_genesis_block.sh

echo "Copying orderer-ca.yaml"
cp -r cas /shared/

echo "Copying utils folder"
cp -r /utils /shared/

echo "Touch the core.yaml"
touch /shared/utils/core.yaml

echo "Done bootstrapping"
touch /shared/bootstrapped
