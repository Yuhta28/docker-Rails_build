#!/bin/bash

set -eu

#Check bundler depend
bundle check || bundle true

exec "$@"
