#!/bin/bash

set -eu

#Exec spring command when start to run Spring sub-command or otpin
 case "${1:-}" in
   binstub | help | sever | status | stop | "-*" )
    set  -- spring "$@"
    ;;
 esac

#Remove socket file when start to run Spring server
 if [ "${1:-}" = spring -a "${2:-}" = server ]; then
   if [ -n "${SPRING_SOCKET}" -a -S "${SPRING_SOCKET}" ]; then
     rm -v "${SPRING_SOCKET}"
   fi
 fi

exec "$@"

