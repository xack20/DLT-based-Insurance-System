#!/bin/bash
# @Author: Zakaria Hossain Foysal
# @Date:   2024-07-29 15:07:59
# @Last Modified by:   Zakaria Hossain Foysal
# @Last Modified time: 2024-07-30 18:35:24
CN=${1:-"kona-dlt"}
CCN=${2:-"merchant-artmining"}
INT_FCN=${3:-"Initialize"}
UN=${4:-"Admin"}

ARG1=${5:-$CCN} # need to change accordingly
ARG2=${6:-"765966cc-f4d9-4489-86fe-834d616a3dc1"}  # need to change accordingly
ARG3=${7:-""}  # TenantId for the merchant service

# check if ARG3 is empty then set conditionally, conditions will be based on CCN
if [ -z "$ARG3" ]; then
    if [ "$CCN" == "merchant-artmining" ]; then
        ARG3="7660b4bc-8023-4039-9a8c-cee1658bd7b2"
    elif [ "$CCN" == "merchant-fleamarket" ]; then
        ARG3="81c8ef3c-1896-4b51-8ff2-30fa0e062acf"
    fi
fi




export PATH=${PWD}/../bin:$PATH
export FABRIC_CFG_PATH=$PWD/../config/

# export FABRIC_CA_CLIENT_HOME=${PWD}/../test-network/organizations/peerOrganizations/org1.example.com/
export FABRIC_CA_CLIENT_HOME=${PWD}/../resources/organizations/peerOrganizations/org1.example.com/


export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
echo ${PWD}
# export CORE_PEER_MSPCONFIGPATH=${PWD}/../test-network/organizations/peerOrganizations/org1.example.com/users/${UN}@org1.example.com/msp
export CORE_PEER_MSPCONFIGPATH=${PWD}/../resources/organizations/peerOrganizations/org1.example.com/users/${UN}@org1.example.com/msp
# export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/../test-network/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/../resources/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_ADDRESS=localhost:7051
# export TARGET_TLS_OPTIONS=(-o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/../test-network/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/../test-network/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/../test-network/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt")

export TARGET_TLS_OPTIONS=(-o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/../resources/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/../resources/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/../resources/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt")

echo "Chaincode Name : $CCN"

# need to change accordingly
if [ "$CCN" == "user-auth-permission" ]; then
    peer chaincode invoke "${TARGET_TLS_OPTIONS[@]}" -C $CN -n $CCN -c "{\"function\":\"Initialize\",\"Args\":[\"${ARG1}\", \"${ARG2}\"]}" --waitForEvent
else
    peer chaincode invoke "${TARGET_TLS_OPTIONS[@]}" -C $CN -n $CCN -c "{\"function\":\"Initialize\",\"Args\":[\"${ARG1}\", \"${ARG2}\", \"${ARG3}\"]}" --waitForEvent
fi
# need to change accordingly

