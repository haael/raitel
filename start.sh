#!/bin/bash

export PYTHONPATH=`ls -d lib/python3.6/site-packages/*.egg | tr '\n' ':'`
export NODE_PATH=lib/node_modules

if ! test -f etc/keystore-password; then
 echo "generating keystore password"
 dd if=/dev/random of=/dev/stdout bs=9 count=1 2>/dev/null | base64 >etc/keystore-password
fi

while [ `bin/geth --config etc/ethereum.conf --verbosity=0 account list | wc -l` -lt 2 ]; do
 echo "creating ethereum account"
 bin/geth --config etc/ethereum.conf --verbosity=0 --password etc/keystore-password account new >/dev/null
done

ADDRESS_LONG=$(bin/encode_eip55.js `bin/geth --config etc/ethereum.conf --verbosity=0 account list | awk 'NR == 1 { print substr($3, 2, length($3) - 2) }'`)
ADDRESS_SHORT=$(bin/encode_eip55.js `bin/geth --config etc/ethereum.conf --verbosity=0 account list | awk 'NR == 2 { print substr($3, 2, length($3) - 2) }'`)

#echo "starting ethereum daemon"
#bin/geth --ropsten --syncmode light --config etc/ethereum.conf --verbosity=3 </dev/null 2>>var/log/geth.log &
#sleep 5

# TODO: wait until geth synchronizes
# It may take long when running the first time.

echo "starting raiden 'long' daemon"
bin/raiden --network-id ropsten --environment-type development --config-file etc/raiden.conf --accept-disclaimer --datadir var/raiden-long --api-address 127.0.0.1:5003 --address $ADDRESS_LONG #1>&2 >>var/log/raiden-long.log &
sleep 1

echo "starting raiden 'short' daemon"
bin/raiden --network-id ropsten --environment-type development --config-file etc/raiden.conf --accept-disclaimer --datadir var/raiden-short --api-address 127.0.0.1:5004 --address $ADDRESS_SHORT #1>&2 >>var/log/raiden-short.log &
sleep 1

## prevent the shell from killing the daemons
#disown

