#!/bin/bash
set -x -e

# all of the packages needed for development

luarocks install busted
luarocks install lua-discount
luarocks install --server=https://luarocks.org/dev luaformatter
luarocks install ldoc
luarocks install luacheck