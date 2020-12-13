#!/bin/bash
# This script generates random password for each user specified on the command line

# Display what the user typed on the command line

echo "The user typed the command ${0}"

# Display the path and filename of the script

echo "Path of the script $(dirname ${0}) filename of the script $(basename ${0})"

# Tell them how many arguments they passed in
# (Inside the script they are parameters, outside they are arguments)
NUMBER_OF_PARAMETERS=${#}
echo "Number of parameters passed in the script ${NUMBER_OF_PARAMETERS}"

#Make sure they at least supply one argument

if [[ ${NUMBER_OF_PARAMETERS} -lt 1 ]]
then
  echo "Usage: {0} USER_NAME [USER_NAME]..."
  exit 1
fi

#Generate and display a password for each parameter
for USER_NAME in "${@}"
do
  PASSWORD=$(date +%S%N | sha256sum | head -c48)
  echo "${USER_NAME}:${PASSWORD}"
done

exit 0