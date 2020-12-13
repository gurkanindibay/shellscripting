#!/bin/bash

# This script generates random password
# User can set the password length with -l and add a special character with -s
# Verbose mode can be enabled with -v

usage(){
  echo "Usage ${0} [-vs][-l LENGTH]" >&2
  echo "Generate a random password"
  echo "-l LENGTH Specify the password length"
  echo "-s        Append a special character to the password"
  echo "-v        Increase verbosity"
  exit 1
}

log(){
  MESSAGE=${@}
  if [[ ${VERBOSE} -eq 'true' ]]
  then
    echo "${MESSAGE}"
  fi
}

# Set a default password length
LENGTH=48

while getopts vl:s OPTION
do
  case ${OPTION} in
    v)
      VERBOSE='true'
      log "Verbose Mode on"
      ;;
    l)
      LENGTH=${OPTARG}
      echo "Length is ${LENGTH}"
      ;;
    s)
      USE_SPECIAL_CHAR='true';
      echo "Special char is enabled"
      ;;
    ?)
      echo "Invalid option." >&2
      usage
      exit 1
      ;;
  esac


done

#echo "Number of args: ${#}"
#echo "All args: ${@}"
#echo "First arg: ${1}"
#echo "Second arg: ${2}"
#echo "Third arg: ${3}"

# Inspect OPTIND


#echo "OPTIND:${OPTIND}"
#Remove the options while remaining other arguments
shift "$((OPTIND - 1 ))"
#echo "OPTIND:${OPTIND}"
#echo "After the shift"
#echo "Number of args: ${#}"
#echo "All args: ${@}"
#echo "First arg: ${1}"
#echo "Second arg: ${2}"
#echo "Third arg: ${3}"

if [[ ${#} -gt 0 ]]
then
  usage
fi

log 'Generating a password'
PASSWORD=$(date +%s%N${RANDOM}${RANDOM}| sha256sum| head -c${LENGTH})
log "Password is ${PASSWORD}"

if [[ ${USE_SPECIAL_CHAR} -eq 'true' ]]
then
  log 'Selecting a random special character'
  SPECIAL_CHAR=$(echo '!@#$&()=?-+*'| fold -w1 | shuf |head -c1)
  PASSWORD="${PASSWORD}${SPECIAL_CHAR}"
fi

log 'Done'
log "Password is ${PASSWORD}"