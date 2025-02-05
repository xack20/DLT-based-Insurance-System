now=$(date +"%T")
echo "Current time : $now"


TO=${1:-"person1"}
TN=${2:-"1"}

FROM=${3:-"person2"}
FN=${4:-"2"}

TID=${5:-"1"}
TRA=${6:-"10"}


PORT="9051"
UORG="2"
if [[ "$TN" == "1" ]] ; then
    PORT="7051"
    UORG="1"
fi

printf "\nTO: $TO\nTN : $TN\nFROM: $FROM\nFN : $FN\nTID: $TID\nTRA: $TRA\nPORT: $PORT\nUORG: $UORG\n\n"



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


# export $(./get_account.sh $TN $TO $UORG | xargs)
# export $(./get_account.sh $FN $FROM 2 | xargs)

export $(./get_account.sh 1 ADMIN 1 | xargs)
export $(./get_account.sh 2 UserA 2 | xargs)
export $(./get_account.sh 3 UserB 2 | xargs)

echo
echo $P1 
echo $P1 | base64 --decode
echo
echo
echo $P2 
echo $P2 | base64 --decode
echo
echo
echo $P3
echo $P3 | base64 --decode
echo 
echo

TOa=$P1
FROMa=$P2


if(($TN == 2 && $FN == 3  )) ; then
    echo "here"
    TOa=$P2
    FROMa=$P3
fi

# printf "\n\nTOa: ${ $TOa | base64 --decode} \nFROMa: ${ $FROMa | base64 --decode}\n\n"

# export $(./get_account.sh 3 person3 2 | xargs)
# export $(./get_account.sh 4 person4 2 | xargs)
# export $(./get_account.sh 5 person5 2 | xargs)

# env

# ./mint.sh ADMIN 1 1 0
# sleep 5
peer chaincode invoke "${TARGET_TLS_OPTIONS[@]}" -C mychannel -n erc1155 -c "{\"function\":\"TransferFrom\",\"Args\":[\"$TOa\",\"$FROMa\",\"$TID\",\"$TRA\"]}" --waitForEvent

peer chaincode query -C mychannel -n erc1155 -c "{\"function\":\"BalanceOf\",\"Args\":[\"$TOa\",\"$TID\"]}"
peer chaincode query -C mychannel -n erc1155 -c "{\"function\":\"BalanceOf\",\"Args\":[\"$FROMa\",\"$TID\"]}"


# # batch transfer 

# peer chaincode invoke "${TARGET_TLS_OPTIONS[@]}" -C mychannel -n erc1155 -c "{\"function\":\"BatchTransferFrom\",\"Args\":[\"$P1\",\"$P2\",\"[3,4,2]\",\"[6,3,1]\"]}" --waitForEvent

# peer chaincode query -C mychannel -n erc1155 -c "{\"function\":\"BalanceOfBatch\",\"Args\":[\"[\\\"$P1\\\",\\\"$P1\\\",\\\"$P1\\\"]\",\"[3,4,2]\"]}"

# peer chaincode query -C mychannel -n erc1155 -c "{\"function\":\"BalanceOfBatch\",\"Args\":[\"[\\\"$P2\\\",\\\"$P2\\\",\\\"$P2\\\"]\",\"[3,4,2]\"]}"


# #batch transfer for multi recipients

# peer chaincode invoke "${TARGET_TLS_OPTIONS[@]}" -C mychannel -n erc1155 -c "{\"function\":\"BatchTransferFromMultiRecipient\",\"Args\":[\"$P1\",\"[\\\"$P3\\\",\\\"$P4\\\",\\\"$P2\\\",\\\"$P5\\\",\\\"$P2\\\"]\",\"[5,3,4,2,6]\",\"[6,6,3,2,3]\"]}" --waitForEvent


# peer chaincode query -C mychannel -n erc1155 -c "{\"function\":\"BalanceOfBatch\",\"Args\":[\"[\\\"$P1\\\",\\\"$P1\\\",\\\"$P1\\\",\\\"$P1\\\",\\\"$P1\\\"]\",\"[2,3,4,5,6]\"]}"

# peer chaincode query -C mychannel -n erc1155 -c "{\"function\":\"BalanceOfBatch\",\"Args\":[\"[\\\"$P2\\\",\\\"$P2\\\"]\",\"[4,6]\"]}"
# peer chaincode query -C mychannel -n erc1155 -c "{\"function\":\"BalanceOf\",\"Args\":[\"$P3\",\"5\"]}"
# peer chaincode query -C mychannel -n erc1155 -c "{\"function\":\"BalanceOf\",\"Args\":[\"$P4\",\"3\"]}"
# peer chaincode query -C mychannel -n erc1155 -c "{\"function\":\"BalanceOf\",\"Args\":[\"$P5\",\"2\"]}"




