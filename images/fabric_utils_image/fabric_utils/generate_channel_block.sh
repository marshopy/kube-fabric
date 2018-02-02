#! /bin/bash

CURRENT_DIR=$(dirname $0)

CHANNEL_NAME=${CHANNEL_NAME:-$1}
CHANNEL_NAME=${CHANNEL_NAME:-"channel"}

${CURRENT_DIR}/replace_configtxyaml.sh

echo "Generating Channel block for Channel name - ${CHANNEL_NAME}"
${CURRENT_DIR}/configtxgen -profile TwoOrgsChannel -outputCreateChannelTx ${CHANNEL_NAME}.tx -channelID ${CHANNEL_NAME}
