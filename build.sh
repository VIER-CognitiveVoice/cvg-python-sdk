#!/usr/bin/env bash

set -euo pipefail

# Merge apis/__init__.py
clients=("assist" "dialog" "call" "recording" "health")
version="${1:-"0.1.0"}"
#openapi_generator_image="openapitools/openapi-generator-cli:v6.2.0@sha256:e6153ebc2f1a54985a50c53942e40285f1fbe64f1c701317da290bfff4abe303"
openapi_generator_image="openapitools/openapi-generator-cli:v6.1.0@sha256:ff52cfd2076751346f79a9b12a060c37680c5dfe086917e0fb1de72be1e4bd0d"
input_base="${INPUT_BASE:-"https://cognitivevoice.io/specs/specs"}"

container_build_dir="/build"
output_folder="out"
package_name="cvg_sdk"
if [ -e "$output_folder" ]
then
  rm -R "$output_folder"
fi
mkdir "$output_folder"

for client in "${clients[@]}"
do
    docker run --rm -t -u "$(id -u):$(id -g)" -v "${PWD}:${container_build_dir}" "$openapi_generator_image" generate -g python -p packageVersion="$version" -p projectName=cvg-python-sdk -p packageName="$package_name" -o "${container_build_dir}/${output_folder}" -i "${input_base}/${client}.yml"
done

echo "" > "${output_folder}/${package_name}/__init__.py"
cp requirements.txt "$output_folder"
sed 's/version = "0.0.1-devel"/version = "'"$version"'"/' < setup.py > "$output_folder/setup.py"

cd "$output_folder"
python setup.py sdist
python setup.py bdist_wheel

