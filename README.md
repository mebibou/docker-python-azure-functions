# docker-python-azure-functions
Docker image containing Python 3.6, .NET and cli packages to deploy on azure

[![Docker Build Status](https://img.shields.io/docker/build/mebibou/docker-python-azure-functions.svg)](https://hub.docker.com/r/mebibou/docker-python-azure-functions/)

This Docker contains:

* python 3.6
* .NET framework version 2.1
* azure-cli@2.0.x
* azure-functions-core-tools@2.0.x

## Usage

If you want to use this image to publish function apps:

```
FROM mebibou/python-azure-functions

# log in to azure
RUN az login --service-principal -u $AZURE_SERVICE_PRINCIPAL_USER --password "$AZURE_SERVICE_PRINCIPAL_PASSWORD" --tenant $AZURE_TENANT > /dev/null

# copy your function apps file
COPY . /app
WORKDIR /app

RUN func settings add FUNCTIONS_WORKER_RUNTIME python
RUN python3.6 -m venv .env
RUN /bin/bash -c "source .env/bin/activate && func azure functionapp publish $FUNCTION_NAME"
```
