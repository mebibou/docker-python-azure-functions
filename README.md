# docker-python-azure-functions
Docker image containing Python 3.6, .NET and cli packages to deploy on azure

[![Docker Build Status](https://img.shields.io/docker/build/mebibou/python-azure-functions.svg)](https://hub.docker.com/r/mebibou/python-azure-functions/)

This Docker is based on `mcr.microsoft.com/azure-functions/python:2.0.12493-python3.6-buildenv` and additionally contains:

* azure-cli@2.0.x
* azure-functions-core-tools@2.0.x

## Usage

If you want to use this image to publish function apps:

```
FROM mebibou/python-azure-functions

ARG AZURE_SERVICE_PRINCIPAL_USER
ARG AZURE_SERVICE_PRINCIPAL_PASSWORD
ARG AZURE_TENANT
# log in to azure
RUN az login --service-principal -u $AZURE_SERVICE_PRINCIPAL_USER --password "$AZURE_SERVICE_PRINCIPAL_PASSWORD" --tenant $AZURE_TENANT > /dev/null

# copy your function apps file
COPY . /app
WORKDIR /app

ARG FUNCTION_NAME
RUN func settings add FUNCTIONS_WORKER_RUNTIME python
RUN pip install --target=".python_packages/lib/python3.6/site-packages" -r requirements.txt
RUN func azure functionapp publish $FUNCTION_NAME --no-build
```

Or you can use it in Gitlab:
```yaml
image: mebibou/python-azure-functions

build:
  script:
    - az login --service-principal -u $AZURE_SERVICE_PRINCIPAL_USER -p "$AZURE_SERVICE_PRINCIPAL_PASSWORD" --tenant $AZURE_TENANT
    - func settings add FUNCTIONS_WORKER_RUNTIME python
    - pip install --target=".python_packages/lib/python3.6/site-packages" -r requirements.txt
    - func azure functionapp publish $FUNCTION_NAME --no-build
```
