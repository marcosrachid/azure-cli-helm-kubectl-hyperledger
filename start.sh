#!/usr/bin/env bash

docker run -it -v /var/run/docker.sock:/var/run/docker.sock -p 9000:8001 kubernetes-hyperledger-az-manager