#!/bin/bash
#Display UID of the user executing this script
# Display if the user is root or not

#Display the UID
echo "Your UID is ${UID}"

#Display the user name

echo "Your user name is $(id -un)"


#Display if the user is root or not

if [[ ${UID} -eq 0 ]]
then
  echo "User is root"
else
  echo "User is not root"
fi

