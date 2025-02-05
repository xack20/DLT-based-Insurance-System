TN=${1:-"1"}
TO=${2:-"person1"}
FN=${3:-"2"}
FROM=${4:-"person2"}

PORT="9051"
UORG="2"
if [[ "$TN" == "1" ]] ; then
    PORT="7051"
    UORG="1"
fi



UNM=$TO


export PATH=${PWD}/../bin:${PWD}:$PATH
export FABRIC_CFG_PATH=$PWD/../config/

export FABRIC_CA_CLIENT_HOME=${PWD}/../test-network/organizations/peerOrganizations/org${UORG}.example.com/

export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org${UORG}MSP"
export CORE_PEER_MSPCONFIGPATH=${PWD}/../test-network/organizations/peerOrganizations/org${UORG}.example.com/users/${UNM}@org${UORG}.example.com/msp
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/../test-network/organizations/peerOrganizations/org${UORG}.example.com/peers/peer0.org${UORG}.example.com/tls/ca.crt
export CORE_PEER_ADDRESS=localhost:${PORT}
export TARGET_TLS_OPTIONS=(-o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/../test-network/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/../test-network/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/../test-network/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt")



export $(./get_account.sh $TN $TO 1 | xargs)
export $(./get_account.sh $FN $FROM 2 | xargs)




peer chaincode invoke "${TARGET_TLS_OPTIONS[@]}" -C mychannel -n erc1155 -c "{\"function\":\"SetApprovalForAll\",\"Args\":[\"$P2\",\"true\"]}" --waitForEvent

peer chaincode query -C mychannel -n erc1155 -c "{\"function\":\"IsApprovedForAll\",\"Args\":[\"$P1\",\"$P2\"]}"