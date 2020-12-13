#!/bin/bash

# This script creates an account on the local file system
#You will be prompted for the account name and password

# Ask for username

read -p 'Enter username to create:' USER_NAME

# Ask for the real name

read -p 'Enter name surname to create:' NAME

#Ask for the password

read -p 'Enter password:' PASSWORD

# Create user
useradd -c "${NAME}" -m "${USER_NAME}"

# Set the password for the user
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

#Force password change on the first login

passwd -e ${USER_NAME}