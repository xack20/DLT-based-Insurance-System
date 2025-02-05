#!/bin/bash

# Variables
ORDERER_ADDRESS="localhost:7050" # Replace with your orderer's address
CHANNEL_NAME="kona-dlt"          # Replace with your channel name
BATCH_TIMEOUT="10ms"            # Desired BatchTimeout value (e.g., 10ms)

# Environment Variables
export PATH=${PWD}/../bin:${PWD}:$PATH
export FABRIC_CFG_PATH=$PWD/../config/
export FABRIC_CA_CLIENT_HOME=${PWD}/../resources/organizations/peerOrganizations/org1.example.com/
export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_MSPCONFIGPATH=${PWD}/../resources/organizations/ordererOrganizations/example.com/users/Admin@example.com/msp
export CORE_PEER_LOCALMSPID="OrdererMSP"
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/../resources/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_ADDRESS=localhost:7051
export ORDERER_CA=${PWD}/../resources/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/tls/ca.crt

# Temporary File Variables
CONFIG_BLOCK_PB="config_block.pb"
CONFIG_BLOCK_JSON="config_block.json"
CONFIG_JSON="config.json"
MODIFIED_CONFIG_JSON="modified_config.json"
CONFIG_PB="config.pb"
MODIFIED_CONFIG_PB="modified_config.pb"
CONFIG_UPDATE_PB="config_update.pb"
CONFIG_UPDATE_JSON="config_update.json"
CONFIG_UPDATE_ENVELOPE_JSON="config_update_in_envelope.json"
CONFIG_UPDATE_ENVELOPE_PB="config_update_in_envelope.pb"
LATEST_CONFIG_BLOCK_PB="latest_config_block.pb"

# Fetch the current channel configuration
peer channel fetch config $CONFIG_BLOCK_PB -o $ORDERER_ADDRESS -c $CHANNEL_NAME --tls --cafile $ORDERER_CA

# Decode the configuration block
configtxlator proto_decode --input $CONFIG_BLOCK_PB --type common.Block --output $CONFIG_BLOCK_JSON

# Extract the configuration
jq .data.data[0].payload.data.config $CONFIG_BLOCK_JSON > $CONFIG_JSON

# Modify the BatchTimeout value
jq ".channel_group.groups.Orderer.values.BatchTimeout.value.timeout = \"$BATCH_TIMEOUT\"" $CONFIG_JSON > $MODIFIED_CONFIG_JSON

# Encode the configurations
configtxlator proto_encode --input $CONFIG_JSON --type common.Config --output $CONFIG_PB
configtxlator proto_encode --input $MODIFIED_CONFIG_JSON --type common.Config --output $MODIFIED_CONFIG_PB

# Compute the update
configtxlator compute_update --channel_id $CHANNEL_NAME --original $CONFIG_PB --updated $MODIFIED_CONFIG_PB --output $CONFIG_UPDATE_PB

# Decode the update
configtxlator proto_decode --input $CONFIG_UPDATE_PB --type common.ConfigUpdate --output $CONFIG_UPDATE_JSON

# Wrap the update in an envelope
echo '{"payload":{"header":{"channel_header":{"channel_id":"'$CHANNEL_NAME'", "type":2}},"data":{"config_update":'$(cat $CONFIG_UPDATE_JSON)'}}}' | jq . > $CONFIG_UPDATE_ENVELOPE_JSON

# Encode the envelope
configtxlator proto_encode --input $CONFIG_UPDATE_ENVELOPE_JSON --type common.Envelope --output $CONFIG_UPDATE_ENVELOPE_PB

# Sign the configuration update
peer channel signconfigtx -f $CONFIG_UPDATE_ENVELOPE_PB

# Submit the updated configuration
peer channel update -f $CONFIG_UPDATE_ENVELOPE_PB -c $CHANNEL_NAME -o $ORDERER_ADDRESS --tls --cafile $ORDERER_CA

# Verify the change
# peer channel fetch config $LATEST_CONFIG_BLOCK_PB -o $ORDERER_ADDRESS -c $CHANNEL_NAME --tls --cafile $ORDERER_CA
# configtxlator proto_decode --input $LATEST_CONFIG_BLOCK_PB --type common.Block | jq .data.data[0].payload.data.config

# Clean up temporary files
rm -f $CONFIG_BLOCK_PB $CONFIG_BLOCK_JSON $CONFIG_JSON $MODIFIED_CONFIG_JSON $CONFIG_PB $MODIFIED_CONFIG_PB $CONFIG_UPDATE_PB $CONFIG_UPDATE_JSON $CONFIG_UPDATE_ENVELOPE_JSON $CONFIG_UPDATE_ENVELOPE_PB $LATEST_CONFIG_BLOCK_PB

# Success Message
echo "BatchTimeout update completed, and temporary files have been removed."

