#!/usr/bin/env bash

docker run -it -v /var/run/docker.sock:/var/run/docker.sock -p 127.0.0.1:8001:8001 kubernetes-hyperledger-az-manager