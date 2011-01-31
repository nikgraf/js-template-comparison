#!/bin/bash

# this script can be used to watch the coffee files of on of these examples
# usage ./runcoffee.sh eco

engine="$1"
build_path="${engine}/build"
src_path="${engine}/src"
coffee --lint --output $build_path --watch $src_path