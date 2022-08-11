#!/bin/bash

# Merge apis/__init__.py
clients=("assist" "dialog" "call" "recording" "health")
version="${1:-"0.1.0"}"
openapi_generator_image="openapitools/openapi-generator-cli:latest"
input_base="${INPUT_BASE:-"https://cognitivevoice.io/specs/specs"}"

container_build_dir="/build"
output_folder="out"
package_name="cvg_sdk"
mkdir "$output_folder"

for client in "${clients[@]}"
do
    docker run --rm -t -u "$(id -u):$(id -g)" -v "${PWD}:${container_build_dir}" "$openapi_generator_image" generate -g python -p packageVersion=$version -p projectName=cvg-python-sdk -p packageName="$package_name" -o "${container_build_dir}/${output_folder}" -i "${input_base}/${client}.yml"
done

echo "" > "${output_folder}/${package_name}/__init__.py"
VERSION="$version" envsubst '$VERSION' < setup.py.in > "${output_folder}/setup.py"

cd "$output_folder"
python setup.py sdist
python setup.py bdist_wheel

