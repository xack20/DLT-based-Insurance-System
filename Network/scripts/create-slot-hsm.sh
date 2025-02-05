set -x

softhsm2-util --init-token --slot 0 --label "ncp-general" --pin 98765432 --so-pin 1234
softhsm2-util --init-token --slot 1 --label "ncp-artmining" --pin 98765433 --so-pin 1234
softhsm2-util --init-token --slot 2 --label "ncp-wine" --pin 98765434 --so-pin 1234
softhsm2-util --init-token --slot 3 --label "ncp-flea-market" --pin 98765435 --so-pin 1234
softhsm2-util --init-token --slot 5 --label "ncp-wallet" --pin 11111111 --so-pin 1111