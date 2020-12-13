#!/bin/bash

PASSWORD=${RANDOM}${RANDOM}${RANDOM}

echo ${PASSWORD}

PASSWORD=$(date +%s)

echo ${PASSWORD}

PASSWORD=$(date +%s%N|sha256sum|head -c32)

echo ${PASSWORD}

SPECIAL_CHAR=$(echo '!^+%&/()=?_'| fold -w1 | shuf | head -c1)

echo ${PASSWORD}${SPECIAL_CHAR}
