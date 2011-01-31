#!/bin/bash

cd eco
docco src/*.coffee
cd ..
cd jquery-tmpl
docco src/*.coffee
cd ..