#!/usr/bin/env bash

# if version not passed in, default to latest released version
HLF_VERSION=1.3.0

# Parse commandline args pull out
# version and/or ca-version strings first
if [ -n "$1" ]; then
    VERSION=$1;shift
    echo "Custom Version found: " $VERSION;
fi

if [[ $VERSION =~ ^[1-9][0-9]*\.[0-9]+\.[0-9]+ ]]; then
    echo "Custom Version is valid";
    if [ $HLF_VERSION != $VERSION ]; then
        HLF_VERSION=$VERSION;
        curl -sSL http://bit.ly/2ysbOFE > init.sh && chmod +x init.sh && ./init.sh $HLF_VERSION -sd && chmod +x bin/*
        rm -f init.sh
    else
        cp bin-dist bin
    fi
else
    echo "Custom Version is empty or invalid. Taking Custom version: " $HLF_VERSION;
    cp bin-dist bin
fi

docker build . -t kubernetes-hyperledger-az-manager

rm -rf bin
