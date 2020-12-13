#!/bin/bash

# This script deletes a user

# Run as root

if [[ "${UID}" -ne 0 ]]
then
  echo "User should be root to proceed" >&2
  exit 1
fi
# Assume the first argument is user to delete
USER=${1}
# Delete the user

userdel ${USER}

# Make sure the user got deleted
if [[ ${?} -ne 0 ]]
then
  echo "User could not be deleted" >=2
  exit 1
fi

#Tell the user account got deleted

echo "The account ${USER} was deleted"

exit 0
