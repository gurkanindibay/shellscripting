
# Display the usage and exit.

# Usage function
usage(){
  echo "Usage ${0} [-dra]" >&2
  echo "Disable a local user"
  echo "-d               Deletes accounts instead of disabling them"
  echo "-r               Removes the home directory associated with the account(s)"
  echo "-a               Creates an archive of the home directory associated with the accounts(s) and stores the archive in the /archives directory"
  echo "[USER_NAME...]   Removes the home directory associated with the account(s)"
  exit 1
}

# Make sure the script is being executed with superuser privileges.

if [[  ${UID} -ne 0 ]]
then
  echo "You should have superuser privileges to execute this script" >&2
  exit 1
fi
DELETE_ACCOUNT='false'
REMOVE_HOME_DIR='false'
CREATE_ARCHIVE_HOME='false'

# Parse the options.
while getopts dra OPTION
do
  case ${OPTION} in
    d)
      DELETE_ACCOUNT='true'
      ;;
    r)
      REMOVE_HOME_DIR='true'
      ;;
    a)
      CREATE_ARCHIVE_HOME='true'
      ;;
    *)
      usage
      ;;
  esac
done

# Remove the options while leaving the remaining arguments.
shift "$((OPTIND-1))"

# If the user doesn't supply at least one argument, give them help.

if [[ ${#} -lt 1 ]]
then
  echo "At least on user should be entered" >&2
  exit 1
fi

# Loop through all the usernames supplied as arguments.
for USER_NAME in "${@}"
do
  # Make sure the UID of the account is at least 1000.
  if [[ "$(id -u ${USER_NAME})" -lt 1000 ]]
  then
    echo "${USER_NAME} could not be processed because it is system account">&2
    exit 1
  fi

  ARCHIVE_FOLDER="/var/tmp/archive"

  # Create an archive if requested to do so.
  if [[ ${CREATE_ARCHIVE_HOME} == 'true' ]]
  then
    echo "Creating archive file for ${USER_NAME}"
    # Make sure the ARCHIVE_DIR directory exists.
    if [[ ! -d  "${ARCHIVE_FOLDER}" ]]
    then
      echo "Creating archive folder"
      mkdir ${ARCHIVE_FOLDER}
    fi
    # Archive the user's home directory and move it into the ARCHIVE_DIR
    tar -cvzf "${USER_NAME}_$(date +%s%N).tgz" "${ARCHIVE_FOLDER}"
    if [[ "${?}" -gt 0 ]]
    then
      echo "There is a problem when archiving the folder" >&2
      exit 1
    fi
  fi
  # Delete the user.
  echo "Delete Account ${DELETE_ACCOUNT}"
  if [[ ${DELETE_ACCOUNT} == 'true' ]]
  then
    echo "Deleting user ${USER_NAME}"
    userdel "${USER_NAME}"

    # Check to see if the userdel command succeeded.
    # We don't want to tell the user that an account was deleted when it hasn't been.
    if [[ "${?}" -gt 0 ]]
    then
      echo "There is a problem when deleting user ${USER}" >&2
      exit 1
    fi
    if [[ ${REMOVE_HOME_DIR} == 'true'  ]]
    then
      echo "Removing Home dir for ${USER_NAME}"
      rm -rf "/home/${USER_NAME}"
    fi
  else
    # Disable the account
    echo "Disabling user ${USER_NAME}"
    chage -E 2020-01-01 ${USER_NAME}
    # Check to see if the chage command succeeded.
    # We don't want to tell the user that an account was disabled when it hasn't been.
    if [[ ${?} -gt 0 ]]
    then
      echo "There is a problem when suspending user ${USER_NAME}" >&2
      exit 1
    fi
  fi







done