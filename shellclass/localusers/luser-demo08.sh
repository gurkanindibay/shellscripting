#!/bin/bash

# The script demonstrates I/O redirection

# Redirect STDOUT to a file
FILE=/tmp/data
head -n1 /etc/passwd > "${FILE}"
# Redirect STDIN to a program
read LINE < ${FILE}
echo "Line Contains ${LINE}"
# Redirect STDOUT to a file, overwriting the file

head -n3 /etc/passwd > "${FILE}"
echo
echo "Contents of the ${FILE}"
cat ${FILE}
# Redirect STDOUT to a file, appending to the file
# >> is used to append
echo "${RANDOM}${RANDOM}" >> ${FILE}
echo "${RANDOM}${RANDOM}" >> ${FILE}
echo
echo "Contents of the appended ${FILE}"
cat ${FILE}


# Redirect STDIN to a program, using FD 0

read LINE 0< ${FILE}
echo "Redirected STDIN from a file "
echo "${LINE}"

# Redirect STDOUT to a file using FD 1, overwriting the file
head -n3 /etc/passwd 1> "${FILE}"
echo "Contents of the file "
cat "${FILE}"

# Redirect STDERR to a file using FD 2
ERR_FILE="/tmp/data.err"
head -n3 /etc/passwd /fake/file 2> "${ERR_FILE}"
echo "Contents of error file"
cat "${ERR_FILE}"

# Redirect STDOUT and STDERROR into a file
head -n3 /etc/passwd &> "${FILE}"
echo "Contents of the file should include both stdout and stderr "
cat "${FILE}"

# Redirect STDOUT and STDERROR through a pipe
head -n3 /etc/passwd /fake/file |& cat -n

