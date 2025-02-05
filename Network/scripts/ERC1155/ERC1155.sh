
# User Creation

# ./add-new-user.sh <username> <password> <affiliation>
./add-new-user.sh 1 ADMIN ADMINpw minter

./add-new-user.sh 2 UserA UserApw customer
./add-new-user.sh 2 UserB UserBpw customer




# Token Initialization

# ./init-contract.sh <user_name>
./init-contract.sh ADMIN
# sleep 2




# Token Minting

# ./mint.sh <user_name> <user_number> <token_id> <token_amount>
./mint.sh ADMIN 1 1 100
# sleep 3


# Token Transferring

# ./transfer.sh <to_user_name> <to_user_number> <from_user_name> <from_user_number> <token_id> <token_amount>
./transfer.sh ADMIN 1 UserA 2 1 2
./transfer.sh ADMIN 1 UserA 2 1 2
./transfer.sh ADMIN 1 UserA 2 1 2
./transfer.sh ADMIN 1 UserA 2 1 2
# sleep 3


# Approval to transfer Token
./set-approval.sh 1 ADMIN 2 UserA


# # Token Transferring UserA to UserB
./transfer.sh UserA 2 UserB 3 1 3

./fetch_block_data.sh 13

./transfer.sh UserA 2 UserB 3 1 1

./fetch_block_data.sh 14