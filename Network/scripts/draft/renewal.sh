#!/bin/bash
# @Author: Zakaria Hossain Foysal
# @Date:   2024-05-28 12:17:30
# @Last Modified by:   Zakaria Hossain Foysal
# @Last Modified time: 2024-05-29 16:37:50

set -e  # Exit immediately if a command exits with a non-zero status

DIR="$(pwd)/../resources/"
echo "Main Directory: ${DIR}"

# Source the reenroll script
source ./reenroll.sh



# Backup the cert for ordererOrg
# cp "${DIR}organizations/fabric-ca/ordererOrg/tls-cert.pem" "${DIR}organizations/fabric-ca/ordererOrg/tls-cert.pem.bak"
rm "${DIR}organizations/fabric-ca/ordererOrg/tls-cert.pem"
docker restart ca_orderer
sleep 10
createOrderer




# Backup the cert for org1
# cp "${DIR}organizations/fabric-ca/org1/tls-cert.pem" "${DIR}organizations/fabric-ca/org1/tls-cert.pem.bak"
rm "${DIR}organizations/fabric-ca/org1/tls-cert.pem"

# Restart the CA container for org1 and wait for it to initialize
docker restart ca_org1
sleep 10

# Create organization
createOrg1





# Backup the cert for org1
# cp "${DIR}organizations/fabric-ca/org2/tls-cert.pem" "${DIR}organizations/fabric-ca/org2/tls-cert.pem.bak"
rm "${DIR}organizations/fabric-ca/org2/tls-cert.pem"

# Restart the CA container for org1 and wait for it to initialize
docker restart ca_org2
sleep 10

# Create organization
createOrg2




# Restart all running Docker containers and wait for them to initialize
docker restart $(docker ps -q)
sleep 30
# docker restart  ca_orderer ca_org1 ca_org2 orderer.example.com couchdb0 couchdb1 
# sleep 10
# docker restart peer0.org1.example.com peer0.org2.example.com cli
# sleep 10





echo "script ends"
