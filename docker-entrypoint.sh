#!/bin/bash

set -eu

#Check bundler depend
bundle check || bundle true

<<<<<<< HEAD
#Check dependance of Yarn
=======
#Check Yarn depend
>>>>>>> modify_docker
yarn check --integrity --silent || true

exec "$@"
