ORG=${1:-"1"}
UN=${2:-"person1"}
PS=${3:-"person1pw"}
AFF=${4:-"minter"}

PORT="7054"

if [[ "$1" == "2" ]] ; then
    PORT="8054"
fi

echo "ORG: ${ORG}"
echo "UN: ${UN}"
echo "PS: ${PS}"
echo "PORT: ${PORT}"
echo "AFF: ${AFF}"

export PATH=${PWD}/../bin:${PWD}:$PATH
export FABRIC_CFG_PATH=$PWD/../config/

export FABRIC_CA_CLIENT_HOME=${PWD}/../test-network/organizations/peerOrganizations/org${ORG}.example.com/



# register a new minter client identity using the fabric-ca-client tool

fabric-ca-client    register                                                                                                               \
--caname            ca-org${ORG}                                                                                                           \
--id.affiliation    org${ORG}.${AFF}                                                                                                       \
--id.name           ${UN}                                                                                                                  \
--id.secret         ${PS}                                                                                                                  \
--id.type           client                                                                                                                 \
--tls.certfiles     ${PWD}/../test-network/organizations/fabric-ca/org${ORG}/tls-cert.pem




# generate the identity certificates and MSP folder by providing the minter's enroll name and secret to the enroll command

fabric-ca-client    enroll                                                                                                                 \
-u                  https://${UN}:${PS}@localhost:${PORT}                                                                                  \
--caname            ca-org${ORG}                                                                                                           \
-M                  ${PWD}/../test-network/organizations/peerOrganizations/org${ORG}.example.com/users/${UN}@org${ORG}.example.com/msp     \
--tls.certfiles     ${PWD}/../test-network/organizations/fabric-ca/org${ORG}/tls-cert.pem




# command below to copy the Node OU configuration file into the minter identity MSP folder

cp                                                                                                                                         \
${PWD}/../test-network/organizations/peerOrganizations/org${ORG}.example.com/msp/config.yaml                                               \
${PWD}/../test-network/organizations/peerOrganizations/org${ORG}.example.com/users/${UN}@org${ORG}.example.com/msp/config.yaml


