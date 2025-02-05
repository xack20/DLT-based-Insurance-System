UN=${1:-"person1"}
UNN=${2:-"1"}

TID=${3:-"1"}
TAMOUNT=${4:-"100"}

PORT="9051"
UORG="2"
if [[ "$UNN" == "1" ]] ; then
    PORT="7051"
    UORG="1"
fi

export PATH=${PWD}/../bin:${PWD}:$PATH
export FABRIC_CFG_PATH=$PWD/../config/

export FABRIC_CA_CLIENT_HOME=${PWD}/../test-network/organizations/peerOrganizations/org${UORG}.example.com/

export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org${UORG}MSP"
export CORE_PEER_MSPCONFIGPATH=${PWD}/../test-network/organizations/peerOrganizations/org${UORG}.example.com/users/${UN}@org${UORG}.example.com/msp
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/../test-network/organizations/peerOrganizations/org${UORG}.example.com/peers/peer0.org${UORG}.example.com/tls/ca.crt
export CORE_PEER_ADDRESS=localhost:${PORT}
export TARGET_TLS_OPTIONS=(-o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/../test-network/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/../test-network/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/../test-network/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt")

export $(./get_account.sh $UNN $UN $UORG | xargs)

echo
echo $P1
echo

peer chaincode invoke "${TARGET_TLS_OPTIONS[@]}" -C mychannel -n erc1155 -c "{\"function\":\"Mint\",\"Args\":[\"$P1\",\"$TID\",\"$TAMOUNT\"]}" --waitForEvent

peer chaincode query -C mychannel -n erc1155 -c "{\"function\":\"BalanceOf\",\"Args\":[\"$P1\",\"$TID\"]}"
















