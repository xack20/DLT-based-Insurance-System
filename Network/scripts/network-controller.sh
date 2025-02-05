initCmd=${1:-"on"}
channelName=${2:-"kona-dlt"}
chaincodeName=${3:-"merchant-artmining"}

if   [ "$initCmd" == "on" ]      ; then
    ../resources/./network.sh down
    # rm -r ../wallet
    ../resources/./network.sh up createChannel -c $channelName -ca -s couchdb
    wait

    # Same Channel Multiple Chaincodes

    ./init-chaincode.sh "${channelName}" merchant-artmining   chaincode-erc1155-go
    ./init-chaincode.sh "${channelName}" merchant-fleamarket  chaincode-erc1155-go
    ./init-chaincode.sh "${channelName}" user-auth-permission authorization-chaincode
    # wait
        
    ./ERC1155/init-contract.sh "${channelName}" merchant-artmining   &
    ./ERC1155/init-contract.sh "${channelName}" merchant-fleamarket  &
    ./ERC1155/init-contract.sh "${channelName}" user-auth-permission &
    wait



    # ./ERCS.sh
elif [ "$initCmd" == "off" ]        ; then
    ../resources/./network.sh down
elif [ "$initCmd" == "-C" ]         ; then
    ../resources/./network.sh createChannel -c $channelName -s couchdb -ca
    
    ./init-chaincode.sh $channelName $chaincodeName
    ./ERC1155/init-contract.sh $channelName $chaincodeName
elif [ "$initCmd" == "backup" ]    ; then
    date=$(date +"%d-%m-%Y--%H-%M-%S-%2N")

    backup_path=$channelName"/"$date

    mkdir -p $backup_path/peer_backups

    sudo docker cp peer0.org1.example.com:/var/hyperledger/production/ $backup_path/peer_backups/peer0.org1/
    sudo docker cp peer0.org2.example.com:/var/hyperledger/production/ $backup_path/peer_backups/peer0.org2/
    sudo docker cp orderer.example.com:/var/hyperledger/production/orderer/ $backup_path/peer_backups/orderer/

    mkdir -p $backup_path/couchdb_backups

    sudo docker cp couchdb0:/opt/couchdb/data/ $backup_path/couchdb_backups/couchdb0/
    sudo docker cp couchdb1:/opt/couchdb/data/ $backup_path/couchdb_backups/couchdb1/

    sudo cp -Ra  ../resources/channel-artifacts $backup_path/
    echo "Channel Artifacts Copied!"
    sudo cp -Ra ../resources/organizations $backup_path/
    echo "Organizations Data Copied!"

    mkdir -p $backup_path/softhsm_backups
    echo "SoftHSM Data Copied!"

    sudo cp -Ra /var/lib/softhsm/tokens/ $backup_path/softhsm_backups/

    mkdir -p $backup_path/postgresdb_backups
    pg_dump -U xack -d blockchaindb -F c -b -f $backup_path/postgresdb_backups/db.backup
    echo "PostgresDB Backup Done!"

    echo
    echo "-------        BACKUP DONE!     ---------"

    # i.e.
    # ./network-controller.sh backup ~/Desktop/NewCommercePlatform/blockchain-backup/
elif [ "$initCmd" == "restore" ]    ; then
    sudo cp -Ra $channelName/channel-artifacts ../resources
    sudo cp -Ra $channelName/organizations ../resources
    sudo cp -Ra $channelName/softhsm_backups/tokens/ /var/lib/softhsm/
    
    ../resources/./network.sh up -ca -s couchdb -rs $channelName

    # i.e.
    # ./network-controller.sh restore ~/Desktop/NewCommercePlatform/blockchain-backup/5-4-23/
elif [ "$initCmd" == "status" ]     ; then
    ../resources/./monitordocker.sh
else
    printf "UnSupported command: $initCmd \nWe are supporting \"on\", \"off\", \"status\", \"backup\", \"restore\".\n"
fi