#!/bin/bash

set -e

for file in examples/*.lua; do
    echo "Running: $file"
    lua "$file"
done