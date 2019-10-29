#!/bin/bash

set -eu

#Check bundler depend
bundle check || bundle true

#Check dependance of Yarn
yarn check --integrity --silent || true

exec "$@"
