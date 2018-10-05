#!/bin/bash

# Configure
AWS_REGION="us-east-1"
REGISTRY="xxxxxxx.dkr.ecr.${AWS_REGION}.amazonaws.com/demo"
TAG=$(git rev-parse --short HEAD)

# Run command output to enable docker credentials
$(aws ecr get-login --no-include-email --region $AWS_REGION)

# Build and push with unique tag and latest to repo
docker build --no-cache=true -t ${REGISTRY}:latest -t "${REGISTRY}:${TAG}" .
docker push ${REGISTRY}:latest
docker push "${REGISTRY}:${TAG}"
