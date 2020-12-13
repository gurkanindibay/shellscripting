#!/bin/bash

SERVER_FILE="/vagrant/servers"


usage(){
  echo "Usage ${0} [-vsn][-f FILENAME]" >&2
  echo "Executes the command on all of the servers"
  echo "-l FILENAME Filename for servers"
  echo "-s          Execute commands with superuser role"
  echo "-v          Increase verbosity"
  echo "-n          Dry Run-- only show commands to be executed "
  exit 1
}


log(){
  MESSAGE=${@}
  if [[ ${VERBOSE} == 'true' ]]
  then
    echo "${MESSAGE}"
  fi
}


while getopts f:nsv OPTION
do
  case ${OPTION} in
    f)
      ${SERVER_FILE}="${OPTARG}"
      ;;
    v)
      VERBOSE="true"
      ;;
    s)
      SUDO_EXEC="true"
      ;;
    n)
      DRY_RUN="true"
      ;;
    ?)
      echo "Invalid Option" >&2
      exit 1;
      ;;
  esac

done

shift "$((OPTIND-1))"

if [[  ${#} -lt 1 ]]
then
  usage
  exit 1
fi

COMMAND=${@}
if [[ "${SUDO_EXEC}" == 'true' ]]
then
  COMMAND="sudo ${COMMAND}"
fi



for SERVER in $(cat ${SERVER_FILE} )
do
  SSH_COMMAND="ssh -o ConnectTimeout=2 ${SERVER} ${COMMAND}"
  echo "Before dry run check"
  if [[ ${DRY_RUN} != "true" ]]
  then
    echo "Executing command ${SSH_COMMAND}"
    RETURN_MESSAGE=$(${SSH_COMMAND} 2>&1)

    if [[ ${?} -ne 0 ]]
    then
      echo -e "Error executing command on server ${SERVER}. Error message:\n${RETURN_MESSAGE}" >&2
      continue;
    else
      echo -e "Command successfully executed on server ${SERVER} Return Message:\n${RETURN_MESSAGE}".
    fi
  else
    echo "Command ${COMMAND} executed in dry run mode"
  fi

done

 exit




