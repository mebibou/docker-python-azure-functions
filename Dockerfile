FROM ubuntu:18.04

RUN apt-get update -y && apt-get install -y curl wget lsb-release software-properties-common

RUN curl -L https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb

# Install .Net
# https://dotnet.microsoft.com/download/linux-package-manager/ubuntu18-04/sdk-current
RUN add-apt-repository universe
RUN apt-get update -y && apt-get install -y apt-transport-https
RUN apt-get update -y && apt-get install -y dotnet-sdk-2.1
RUN apt-get install -y azure-functions-core-tools

# Install Azure CLI
# https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-apt
RUN AZ_REPO=$(lsb_release -cs) && \
    echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | \
      tee /etc/apt/sources.list.d/azure-cli.list
RUN apt-get update -y && apt-get install -y azure-cli

# Install python3.6 and prepare env
# https://docs.microsoft.com/en-us/azure/azure-functions/functions-create-first-function-python#create-and-activate-a-virtual-environment
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt-get update && apt-get install -y python3.6 python3-venv python3.6-venv

# clean up
RUN apt-get remove -y curl wget lsb-release software-properties-common

# RUN az --version
# RUN func --gpuversion

