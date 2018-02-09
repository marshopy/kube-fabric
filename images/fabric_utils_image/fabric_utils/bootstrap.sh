#! /bin/bash

CURRENT_DIR=$(dirname $0)

echo "Deleting old stuff"
rm -rf /shared/*
rm -rf /shared/utils
rm -rf /utils/orderer.block

echo "Generating crypto material"
${CURRENT_DIR}/generate_crypto.sh

echo "Generating genesis block"
${CURRENT_DIR}/generate_genesis_block.sh

echo "Generating channel block"
${CURRENT_DIR}/generate_channel_block.sh ${CHANNEL_NAME}

echo "Copying utils folder"
cp -r /utils /shared/

echo "Done bootstrapping"
touch /shared/bootstrapped
