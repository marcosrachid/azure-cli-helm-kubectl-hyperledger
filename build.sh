#!/usr/bin/env bash

# if version not passed in, default to latest released version
HLF_VERSION=1.4.2

# Parse commandline args pull out
# version and/or ca-version strings first
if [ -n "$1" ]; then
    VERSION=$1;shift
    echo "Custom Version found: " $VERSION;
fi

if [[ $VERSION =~ ^[1-9][0-9]*\.[0-9]+\.[0-9]+ ]]; then
    HLF_VERSION=$VERSION;
    echo "Custom Version is valid";
else
    echo "Custom Version is invalid. Taking Custom version: " $HLF_VERSION;
fi

curl -sSL http://bit.ly/2ysbOFE > init.sh && chmod +x init.sh
[ -s ./init.sh ] || cp init_dist.sh init.sh && chmod +x init.sh;

docker build .  --build-arg HLF_VERSION=$HLF_VERSION -t kubernetes-hyperledger-az-manager

rm -f init.sh