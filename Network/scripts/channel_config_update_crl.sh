#!/bin/bash
# @Author: Zakaria Hossain Foysal
# @Date:   2024-07-03 16:02:28
# @Last Modified by:   Zakaria Hossain Foysal
# @Last Modified time: 2024-07-04 23:31:49

# create help to show the usage of the script
# if no param passed also show the help

CH_NAME=$1
CRL=$2
RUN_PATH=$3

if [ -z "$RUN_PATH" ]; then

    RUN_PATH=$(pwd)

    if [ "$#" -eq 0 ] || [ "$CH_NAME" == "-h" ]; then
        echo "Usage: "
        echo "  channel_config_update_crl.sh <channel_name> <CRL>"
        echo "  channel_config_update_crl.sh kona-dlt LS0tLS1CRUdJTiBYNTA...0tLUVORCBYNTA5IENSTC0tLS0tCg=="
        exit
    fi

    CH_NAME=${1:-"kona-dlt"}
    CRL=${2:-"NOT_PROVIDED"}

    if [ "$CH_NAME" == "kona-dlt" ]; then
        # Inform user that channel value default set to 'kona-dlt'
        echo "Channel name is set to default value 'kona-dlt'"
        # Type 'y' to continue or 'n' to terminate the script
        read -p "Do you want to continue? (y/n): " choice
        if [ "$choice" == "n" ]; then
            exit 1
        fi
    fi

    # check if CRL or ChannelName not provided then terminate the script
    if [ "$CRL" == "NOT_PROVIDED" ]; then
        echo "Please provide the CRL (base64 encoded) to update the channel configuration"
        exit 1
    fi
fi





export PATH=${RUN_PATH}/../bin:$PATH
export FABRIC_CFG_PATH=$RUN_PATH/../config/

export CORE_PEER_MSPCONFIGPATH=${RUN_PATH}/../resources/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_TLS_ENABLED=true

rm -rf config_block.pb

peer channel fetch config config_block.pb -o localhost:7050 --tls --cafile "${RUN_PATH}/../resources/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" -c ${CH_NAME}

configtxlator proto_decode --input config_block.pb --type common.Block --output config_block.json

jq ".data.data[0].payload.data.config" config_block.json > config.json

cp config.json modified_config.json

jq '.channel_group.groups.Application.groups.Org1MSP.values.MSP.value.config.revocation_list += ["'${CRL}'"]' modified_config.json > tmp.json && mv tmp.json modified_config.json

configtxlator proto_encode --input config.json --type common.Config --output config.pb

configtxlator proto_encode --input modified_config.json --type common.Config --output modified_config.pb

configtxlator compute_update --channel_id ${CH_NAME} --original config.pb --updated modified_config.pb --output config_update.pb

configtxlator proto_decode --input config_update.pb --type common.ConfigUpdate --output config_update.json

echo '{"payload":{"header":{"channel_header":{"channel_id":"'${CH_NAME}'", "type":2}},"data":{"config_update":'$(cat config_update.json)'}}}' | jq . > config_update_in_envelope.json

configtxlator proto_encode --input config_update_in_envelope.json --type common.Envelope --output config_update_in_envelope.pb

peer channel update -f config_update_in_envelope.pb -c ${CH_NAME} -o localhost:7050 --tls --cafile "${RUN_PATH}/../resources/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem"

rm -rf config_block.pb config_block.json config.json modified_config.json config.pb modified_config.pb config_update.json config_update.pb config_update_in_envelope.json config_update_in_envelope.pb
