#! /bin/bash

CHANNEL_NAME=${1:-${CHANNEL_NAME}}
COUNTER=1
MAX_RETRY=5
DELAY=5

sleep 5
echo "Fetching channel block for ${CHANNEL_NAME}"
/usr/bin/peer channel fetch --logging-level debug -o ${ORDERER_URL} -c ${CHANNEL_NAME} >&log.txt

echo "Joining channel block for channel name ${CHANNEL_NAME}"

joinWithRetry() {
    /usr/bin/peer channel join --logging-level debug -b "${PEER_CFG_PATH}/${CHANNEL_NAME}.block"
    rc=$?
    if [ $rc -ne 0 -a $COUNTER -lt $MAX_RETRY ]; then
        COUNTER=` expr $COUNTER + 1`
        echo "PEER$1 failed to join the channel, Retry after 2 seconds"
        sleep $DELAY
        joinWithRetry $1
    fi

    if [ $rc -ne 0 ]; then
        echo "Failed to join the channel after $MAX_RETRY attempts, PEER${ch} has failed to Join the Channel"
        exit 1
    fi
}

setGlobals() {

	if [ $1 -eq 0 -o $1 -eq 1 ] ; then
		export CORE_PEER_LOCALMSPID="Org1MSP"
		export CORE_PEER_TLS_ROOTCERT_FILE=/shared/crypto-config/peerOrganizations/peerorg1/peers/peer1.peerorg1/tls/ca.crt
		export CORE_PEER_MSPCONFIGPATH=/shared/crypto-config/peerOrganizations/peerorg1/users/Admin@peerorg1/msp
		if [ $1 -eq 0 ]; then
			export CORE_PEER_ADDRESS=peer1.peerorg1:7051
		else
			export CORE_PEER_ADDRESS=peer2.peerorg1:7051
		fi
	else
		export CORE_PEER_LOCALMSPID="Org2MSP"
		export CORE_PEER_TLS_ROOTCERT_FILE=/shared/crypto-config/peerOrganizations/peerorg2/peers/peer1.peerorg2/tls/ca.crt
		export CORE_PEER_MSPCONFIGPATH=/shared/crypto-config/peerOrganizations/peerorg2/users/Admin@peerorg2/msp
		if [ $1 -eq 2 ]; then
			export CORE_PEER_ADDRESS=peer1.peerorg2:7051
		else
			export CORE_PEER_ADDRESS=peer2.peerorg2:7051
		fi
	fi
}

joinChannel() {
	for ch in `seq 0 3`; do
	    setGlobals $ch
		joinWithRetry $ch
		sleep $DELAY
	done
}

joinChannel || true

