#!/bin/bash -x

echo "Sleep for 30 seconds so the master node has initialised"
sleep 30

echo "Setup /root/.multichain/multichain.conf"
mkdir -p /root/.multichain/
cat << EOF > /root/.multichain/multichain.conf
rpcuser=$RPC_USER
rpcpassword=$RPC_PASSWORD
rpcport=$RPC_PORT
EOF
for ip in ${RPC_ALLOW_IP//,/ } ; do
   echo "rpcallowip=$ip" >> /root/.multichain/multichain.conf
done

echo "Start the chain"
multichaind -txindex -printtoconsole -shrinkdebugfilesize $CHAINNAME@$MASTER_NODE:$NETWORK_PORT
