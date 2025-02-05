AH=${1:-"ADMIN"}
AHN=${2:-"1"}
TID=${3:-"1"}

PORT="9051"
UORG="2"
if [[ "$AHN" == "1" ]] ; then
    PORT="7051"
    UORG="1"
fi

printf "\n\nAH: ${AH} \nAHN: ${AHN} \nTID: ${TID} \nUORG: ${UORG}\n\n"

export PATH=${PWD}/../bin:${PWD}:$PATH
export FABRIC_CFG_PATH=$PWD/../config/

export FABRIC_CA_CLIENT_HOME=${PWD}/../test-network/organizations/peerOrganizations/org${UORG}.example.com/

export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org${UORG}MSP"
export CORE_PEER_MSPCONFIGPATH=${PWD}/../test-network/organizations/peerOrganizations/org${UORG}.example.com/users/$AH@org${UORG}.example.com/msp
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/../test-network/organizations/peerOrganizations/org${UORG}.example.com/peers/peer0.org${UORG}.example.com/tls/ca.crt
export CORE_PEER_ADDRESS=localhost:$PORT
export TARGET_TLS_OPTIONS=(-o localhost:7050 --ordererTLSHostnameOverride orderer.example.com --tls --cafile "${PWD}/../test-network/organizations/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem" --peerAddresses localhost:7051 --tlsRootCertFiles "${PWD}/../test-network/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt" --peerAddresses localhost:9051 --tlsRootCertFiles "${PWD}/../test-network/organizations/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt")

export $(./get_account.sh 1 ADMIN 1 | xargs)
export $(./get_account.sh 2 UserA 2 | xargs)
export $(./get_account.sh 3 UserB 2 | xargs)

PP=$P1
if(($AHN == 2)) ; then
    PP=$P2
elif(($AHN == 3)) ; then
    PP=$P3
fi

peer chaincode query -C mychannel -n erc1155 -c "{\"function\":\"BalanceOf\",\"Args\":[\"$PP\",\"$TID\"]}"


# batch check
# peer chaincode query -C mychannel -n erc1155 -c "{\"function\":\"BalanceOfBatch\",\"Args\":[\"[\\\"$P1\\\"]\",\"[$TID]\"]}"
