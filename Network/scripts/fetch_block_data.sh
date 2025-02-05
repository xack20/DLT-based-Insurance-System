BN=${1:-"1"}
cn=${2:-"kona-dlt"}
now=$(date +"%T_%d-%m-%y")

export PATH=${PWD}/../bin:${PWD}:$PATH
export FABRIC_CFG_PATH=$PWD/../config/

export FABRIC_CA_CLIENT_HOME=${PWD}/../resources/organizations/peerOrganizations/org1.example.com/

export CORE_PEER_TLS_ENABLED=true
export CORE_PEER_LOCALMSPID="Org1MSP"
export CORE_PEER_MSPCONFIGPATH=${PWD}/../resources/organizations/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
export CORE_PEER_TLS_ROOTCERT_FILE=${PWD}/../resources/organizations/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
export CORE_PEER_ADDRESS=localhost:7051



peer channel fetch $BN block_$BN.pb -c $cn

mkdir -p ../blocks

configtxlator proto_decode --input block_$BN.pb --type common.Block --output ../blocks/${now}_block_${BN}.json

rm -f block_$BN.pb

