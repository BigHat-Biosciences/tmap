#!/bin/bash

set -e

# aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 332120041740.dkr.ecr.us-east-1.amazonaws.com

DOCKER_BUILDKIT=1 docker buildx build --secret id=aws,src=$HOME/.aws/credentials --secret id=CODEARTIFACT_TOKEN,src=<(aws codeartifact get-authorization-token --domain bighatbio-com --query authorizationToken --output text) --platform linux/amd64 -t bh-tmap -f Dockerfile .
