#!/bin/bash

set -e
export VERSION=`git describe --tags`
echo -n "${VERSION}" > .version

go build -o sitegen 
./sitegen $1
rm sitegen

# run the tests in xbarapp.com - we may have
# just broken them
cd ../../xbarapp.com
npm install
./gen.sh
npm run build
go test
