#!/bin/bash

# This script shows the open network ports on a system

netstat -nutl ${1} | grep ':' |awk '{print $4}' | awk -F ':' '{print $NF}'