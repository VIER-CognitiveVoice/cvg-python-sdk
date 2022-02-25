#!/bin/bash

# Merge apis/__init__.py
CLIENTS=("webhook.yml" "assist_endpoint.yml" "call.yml")

for f in "${CLIENTS[@]}"
do
  FILE=api-specs/$f
	docker-entrypoint.sh generate -g python -p projectName=cvg-python-sdk -o $PWD/out -i $FILE
done 
