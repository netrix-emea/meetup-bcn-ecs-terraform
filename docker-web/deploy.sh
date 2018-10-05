#!/bin/bash

AWS_REGION="us-east-1"
REGISTRY="xxxxxxx.dkr.ecr.${AWS_REGION}.amazonaws.com/demo"

./ecs-deploy.sh -n demo -c demo -i "${REGISTRY}:latest"
