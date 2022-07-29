#!/bin/bash

# Merge apis/__init__.py
CLIENTS=("assist.yml" "dialog.yml" "call.yml")
VERSION="1.0.1"

for f in "${CLIENTS[@]}"
do
  FILE=api-specs/$f
  docker-entrypoint.sh generate -g python -p packageVersion=$VERSION -p projectName=cvg-python-sdk -p packageName=cvg_sdk -o $PWD/out -i $FILE
done 
