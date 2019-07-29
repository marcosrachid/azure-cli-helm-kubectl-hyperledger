FROM debian:jessie

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ENV AZURE_CLI_VERSION "0.10.17"
ENV NODEJS_APT_ROOT "node_6.x"
ENV NODEJS_VERSION "6.11.3"
ARG HLF_VERSION

EXPOSE 8001
LABEL name=kubernetes-hyperledger-az-manager version=dev \
      maintainer="Marcos Rachid <marcosrachid@gmail.com>" 

RUN apt-get update -qq && \
    apt-get install -qqy --no-install-recommends \
      apt-transport-https \
      build-essential \
      curl \
      ca-certificates \
      apt-transport-https \
      git \
      lsb-release \
      gnupg \
      gnupg2 \
      python-all \
      rlwrap \
      vim \
      nano \
      jq \
      software-properties-common

# repo azure-cli
RUN curl -sL https://packages.microsoft.com/keys/microsoft.asc | \
      gpg --dearmor | \
      tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null && \
    AZ_REPO=$(lsb_release -cs) && echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
      tee /etc/apt/sources.list.d/azure-cli.list && \
    apt-get update && apt-get install -y azure-cli

RUN apt-get update -qq && \
    apt-get install -qqy --no-install-recommends \
      docker-ce \
      azure-cli

# kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
      chmod +x ./kubectl && \
      mv ./kubectl /usr/local/bin/kubectl

# helm
RUN curl -L https://git.io/get_helm.sh | bash

# cryptogen binaries
COPY init.sh /fabric/
RUN chmod +x /fabric/init.sh && \
    /fabric/init.sh $HLF_VERSION -sd && \
    rm -f /fabric

ENV EDITOR vim