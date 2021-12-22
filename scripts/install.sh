#!/bin/bash
set -x -e

# all of the packages for development

# testing
luarocks install busted

# docs
luarocks install ldoc
luarocks install lua-discount

# linting / formatting
luarocks install --server=https://luarocks.org/dev luaformatter
luarocks install luacheck

# utility
luarocks install inspect
