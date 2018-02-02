#! /bin/bash

echo "Generating Genesis Block for the orderer"

CURRENT_DIR=$(dirname $0)

${CURRENT_DIR}/replace_configtxyaml.sh

${CURRENT_DIR}/configtxgen -profile TwoOrgsOrdererGenesis -outputBlock orderer.block
cp orderer.block /shared/
