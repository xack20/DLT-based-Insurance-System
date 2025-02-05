#!/bin/bash
# @Author: Zakaria Hossain Foysal
# @Date:   2024-07-03 19:10:44
# @Last Modified by:   Zakaria Hossain Foysal
# @Last Modified time: 2024-07-29 15:08:10
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



export $(./get_chaincode_version.sh "$ccn"_)

echo Current Chaincode Version : $CCV

ccv="`expr $CCV + 1`.0.1"
ccs=`expr $CCV + 1`


# Chaincode Upgradation
../resources/./network.sh    upgradeCC                                                        \
-c                                 $cn                      							      \
-ccn                               $ccn                                                       \
-ccp                               $ccp                                                       \
-ccl                               $lang                                                      \
-ccv                               $ccv                                                       \
-ccs                               $ccs                                                       \
# -ccep                              "OR('Org1MSP.peer','Org2MSP.peer')"

###TODO - lang name should be passed below as parameter
# ./ERC1155/init-contract.sh $cn $ccn