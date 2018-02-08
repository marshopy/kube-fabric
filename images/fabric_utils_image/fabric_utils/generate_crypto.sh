#! /bin/bash

echo "Generating Crypto Material"
CURRENT_DIR=$(dirname $0)

${CURRENT_DIR}/cryptogen generate --config ${CURRENT_DIR}/crypto-config.yaml

cp -r crypto-config /shared/

# Delete admin certs so anyone on the org can perform transaction
# find /shared/ -iname admincerts -type f -exec rm -f {} \;

for file in $(find /shared/ -iname *_sk); do
    dir=$(dirname $file)
    mv -vf ${dir}/*_sk ${dir}/key.pem
done
