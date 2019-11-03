#!/bin/bash

set -eu

#Check bundler depend
bundle check || bundle true

#Check Yarn depend
yarn check --integrity --silent || true

exec "$@"
