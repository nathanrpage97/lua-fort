#!/bin/bash

for file in examples/*.lua; do
    lua $file;
done