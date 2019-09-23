#!/bin/bash

REMOTE_SYSTEM=$1
REMOTE_IP=$2
REMOTE_PORT=$3
LOCALPORT=$4
USERNAME=$5

echo "----------------------"
echo "$0 - v0.1"
echo "----------------------"
echo " "

if [ -z "$REMOTE_PORT" ] ; then
  echo "Usage:"
  echo "$0 <Environment> <IP/ALIAS> <Port> <localport>[<username>]"
  echo " "
  echo "Available environments:"
  echo "- pre-b"
  echo "- prod-b"
  echo "- prod-pci"
  echo "- pre-pci"
  exit 1
elif [ "$REMOTE_PORT" == "22" ]; then
  echo "ERROR: Please use ssh for accessing machines via jump host configuration:"
  echo "ssh -F ~/.ssh/ssh-production.config root@$REMOTE_IP"
  exit 2
fi

if [ -z "$USERNAME" ] ; then    
   USERNAME=$(echo $USER |  awk -F '.' '{print tolower(substr($1,1,1)$NF)}')
fi

if [ -z "$LOCALPORT" ] ; then    
   LOCALPORT=12345
fi

echo "Bastionhost username: $USERNAME"


CMD="ssh -N -p 22 ${USERNAME}@bastionhost-${REMOTE_SYSTEM}.numberfour.eu -L $LOCALPORT:${REMOTE_IP}:${REMOTE_PORT}"
echo "----------------------------------------------------"
echo "Creating tunnel using:"
echo $CMD
echo "----------------------------------------------------"
echo "Localport $LOCALPORT will be mapped to ${REMOTE_IP}:${REMOTE_PORT}"
echo "Press CTRL-C to terminate the connection."
$CMD
echo "----------------------------------------------------"
echo "END"
echo " "