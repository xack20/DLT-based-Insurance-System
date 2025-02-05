cn=${1:-"kona-dlt"}
ccn=${2:-"merchant-artmining"}
ccp=../../Chaincodes/${3:-"chaincode-erc1155-go"}
lang=${4:-"go"}


if  [[ "$lang" == "js" || "$lang" == "javascript" || "$lang" == "node" ]]      ; then
    lang="javascript"
elif [[ "$lang" == "go" || "$lang" == "golang" ]]    ; then
    lang="go"
elif [ "$lang" == "java" ] ; then
    lang="java"
else
    printf "UnSupported language: $lang \nWe are supporting javascript, go, java. \nSetting Default language \"Go\"......\n"
fi


# ccp=../../Chaincodes/chaincode-$ccn-$lang/




# Chaincode Installation

../resources/./network.sh    deployCC                                                         \
-c 				                   $cn                      							      \
-ccn                               $ccn                                                       \
-ccp                               $ccp                                                       \
-ccl                               $lang                                                      \
# -ccep                              "OR('Org1MSP.peer','Org2MSP.peer')"
