#!/bin/sh

echo $GENESIS > /root/.ethereum/genesis.json
geth init /root/.ethereum/genesis.json

DEFAULT_ARGS="--networkid $NETWORK_ID --bootnodes enode://$(bootnode -nodekeyhex $BOOTNODE_KEY -writeaddress)@$BOOTNODE_SERVICE_HOST:$BOOTNODE_SERVICE_PORT"

geth $DEFAULT_ARGS $@
