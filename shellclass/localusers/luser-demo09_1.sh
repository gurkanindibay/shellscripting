#!/bin/bash

#if [[ ${1} == 'start' ]]
#then
#  echo 'Starting'
#elif [[ ${1} == 'stop' ]]
#then
#  echo 'Stopping'
#elif [[ ${1} == 'status' ]]
#then
#  echo 'Status: '
#else
#  echo "Not Supported" >&2
#  exit 1
#fi

case ${1} in
  start) echo 'starting' ;;
  stop) echo 'stopping' ;;
  status|state)
    echo 'status'
    ;;
  *)
    echo ' Not Supported' >&2
    exit 1
    ;;
esac