#! /bin/bash

CURRENT_DIR=$(dirname $0)

CHANNEL_NAME=${1:-${CHANNEL_NAME}}
ORDERER_URL=${2:-${ORDERER_URL}}

cd /shared/utils/

${CURRENT_DIR}/replace_configtxyaml.sh

set +e
echo "Generating channel block for channel name ${CHANNEL_NAME}"
${CURRENT_DIR}/generate_channel_block.sh ${CHANNEL_NAME}

echo "Creating channel ${CHANNEL_NAME}"

if [ -z "$CORE_PEER_TLS_ENABLED" -o "$CORE_PEER_TLS_ENABLED" = "false" ]; then
    /usr/bin/peer channel create --logging-level debug -o ${ORDERER_URL} -c ${CHANNEL_NAME} -f ${CHANNEL_NAME}.tx >&log.txt
else
    /usr/bin/peer channel create --logging-level debug -o ${ORDERER_URL} -c ${CHANNEL_NAME} -f ${CHANNEL_NAME}.tx --tls ${CORE_PEER_TLS_ENABLED} --cafile ${ORDERER_CA} >&log.txt
fi

set -e
