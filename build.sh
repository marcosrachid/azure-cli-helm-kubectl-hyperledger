#!/usr/bin/env bash

curl -sSL http://bit.ly/2ysbOFE > init.sh && chmod +x init.sh
./init.sh -sb
docker build . -t kubernetes-hyperledger-az-manager
rm init.sh
