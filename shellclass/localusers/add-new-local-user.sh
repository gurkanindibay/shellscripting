
# Make sure the script is being executed with superuser privileges.

if [[ ${UID} -ne 0 ]]
then
  echo "You should have superuser privileges to continue"
  exit 1
fi


# If the user doesn't supply at least one argument, then give them help.
NUMBER_OF_PARAMETERS=${#}

if [[ ${NUMBER_OF_PARAMETERS} -lt 1 ]]
then
  echo "Usage: {0} USER_NAME [COMMENT]..."
fi
# The first parameter is the user name.
USER_NAME=${1}
# The rest of the parameters are for the account comments.
#COMMENT=""
#shift
#while [[ ${#} -gt 0 ]]
#do
#  COMMENT="${COMMENT} ${1}"
#  shift
#done

shift
COMMENT=${@}

#echo "Comment ${COMMENT}"


# Generate a password.
PASSWORD=$(date +%s%N|sha256sum|head -c32)
# Create the user with the password.
useradd -m "${USER_NAME}"
# Check to see if the useradd command succeeded.
if [[ ${?} -ne 0 ]]
then
  echo "User could not be added. Return code ${?}"
fi
# Set the password.
echo "${PASSWORD}" | passwd --stdin "${USER_NAME}"

# Check to see if the passwd command succeeded.
if [[ ${?} -ne 0 ]]
then
  echo "Password could not be set. Return code ${?}"
fi

# Force password change on first login.
passwd -e ${USER_NAME}

# Display the username, password, and the host where the user was created.
echo "User ${USER_NAME} created on ${HOSTNAME} with password ${PASSWORD} "