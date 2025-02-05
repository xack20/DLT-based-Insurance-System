cc_type=${1:-"all"}
cn=${2:-"kona-dlt"}

if [ $cc_type == "auth" ]; then
    ./upgrade-chaincode.sh $cn user-auth-permission authorization-chaincode
    exit 0
elif [ $cc_type == "art" ]; then
    ./upgrade-chaincode.sh $cn merchant-artmining chaincode-erc1155-go
    exit 0
elif [ $cc_type == "flea" ]; then
    ./upgrade-chaincode.sh $cn merchant-fleamarket chaincode-erc1155-go
    exit 0
elif [ $cc_type == "all" ]; then
    ./upgrade-chaincode.sh $cn user-auth-permission authorization-chaincode
    ./upgrade-chaincode.sh $cn merchant-artmining chaincode-erc1155-go
    ./upgrade-chaincode.sh $cn merchant-fleamarket chaincode-erc1155-go
    exit 0
fi