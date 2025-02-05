UNN=$1
UNM=$2
UORG=$3

PORT="7051"

if [[ "$UORG" == "2" ]] ; then
    PORT="9051"
fi

export PATH=${PWD}/../bin:${PWD}:$PATH
export FABRIC_CFG_PATH=$PWD/../config/

export FABRIC_CA_CLIENT_HOME=${PWD}/../test-network/organizations/peerOrganizations/org${UORG}.example.com/

export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org${UORG}MSP"
export CORE_PEER_MSPCONFIGPATH=${PWD}/../test-network/organizations/peerOrganizations/org${UORG}.example.com/users/${UNM}@org${UORG}.example.com/msp
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/../test-network/organizations/peerOrganizations/org${UORG}.example.com/peers/peer0.org${UORG}.example.com/tls/ca.crt
export CORE_PEER_ADDRESS=localhost:${PORT}
export TARGET_TLS_OPTIONS=(-o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/../test-network/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/../test-network/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/../test-network/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt")




ACC=$(peer chaincode query -C mychannel -n erc1155 -c '{"function":"ClientAccountID","Args":[]}')

# echo
# echo $ACC
# echo
# echo $ACC | base64 --decode
# echo


echo "P${UNN}=\"${ACC}\""
