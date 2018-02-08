#! /bin/bash

CURRENT_DIR=$(dirname $0)

CHANNEL_NAME=${CHANNEL_NAME:-$1}
CHANNEL_NAME=${CHANNEL_NAME:-"mychannel"}

# ${CURRENT_DIR}/replace_configtxyaml.sh

echo "Generating Channel block for Channel name - ${CHANNEL_NAME}"
${CURRENT_DIR}/configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ${CHANNEL_NAME}.tx -channelID ${CHANNEL_NAME}

for orgname in Org1MSP Org2MSP; do
    ${CURRENT_DIR}/configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ${CHANNEL_NAME}.tx -channelID ${CHANNEL_NAME} -asOrg ${orgname}
done