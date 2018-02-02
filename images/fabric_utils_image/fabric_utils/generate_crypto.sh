#! /bin/bash

echo "Generating Crypto Material"
CURRENT_DIR=$(dirname $0)

${CURRENT_DIR}/cryptogen -peerOrgs 2 -peersPerOrg 1 -ordererNodes 1 -baseDir /utils/

cp -r crypto-config /shared/

# Delete admin certs so anyone on the org can perform transaction
find /shared/ -iname admincerts -type f -exec rm -f {} \;

for file in $(find /shared/ -iname *_sk); do 
    dir=$(dirname $file)
    mv ${dir}/*_sk ${dir}/key.pem
done
