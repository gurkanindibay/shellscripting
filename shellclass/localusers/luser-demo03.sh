#!/bin/bash

#Display UID and username of the user executing this script
USER_NAME=$(id -un)
echo "UID and username of the user is : ${UID} and ${USER_NAME}"

#Display the UID

# Only display if the user id does not match 1000

if [[ ${UID}  -ne  1000 ]]
then
  echo "Your user id is not 1000"
fi

#Display the username

# Test if the command succeeded

if [[ ${USER_NAME} = "vagrant" ]]
then
  echo "User is vagrant"
  exit 0
else
  echo "User is not vagrant"
  exit 1
fi

#you can use a string test conditional


#Test for != for the string