#!/usr/bin/env bash

docker run -it \
-p 127.0.0.1:8001:8001 \
-v /var/run/docker.sock:/var/run/docker.sock \
-v $GOROOT:/opt/goroot \
-v $GOPATH:/opt/gopath \
-v $(pwd)/bin:/opt/fabric/bin \
kubernetes-hyperledger-az-manager
