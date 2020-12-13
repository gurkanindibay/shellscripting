#!/bin/bash

log(){
  local VERBOSE=${1}
  shift
  local MESSAGE=${@}
  if [[ ${VERBOSE} == 'true' ]]
  then
    echo "${MESSAGE}"
  fi
  logger -t luser-demo10.sh "${MESSAGE}"
}

backup_file() {
  # This function creates a backup of a file. Returns non zero status on error
  local FILE=${1}

  # Make sure the file exists and name the new file with a timestamp
  if [[ -f "${FILE}" ]]
  then
    BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
    log "Backing up ${FILE} to ${BACKUP_FILE}"
    cp -p "${FILE}" "${BACKUP_FILE}"
  else
    return 1
  fi

}

#VERBOSITY='true'
#log ${VERBOSITY} "Hello" "Test"
#log ${VERBOSITY} "This is fun"

backup_file '/etc/passwd'

# Give a success or failure message according to return code of copy file
if [[ ${?} -eq 0 ]]
then
  echo "File ${FILE} successfully copied"
else
  echo "File ${FILE} can not be copied"
fi