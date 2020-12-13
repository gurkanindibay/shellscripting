#!/bin/bash
# Display the top three most visited URLs for a given web server file

# mine
awk -F '"' '{print $2}' access_log | awk '{print $2}' | sort | uniq -c| sort -n | tail -3f
awk -F '"' '{print $2}' access_log | awk '{print $2}' | sort | uniq -c| sort -nr| head -n3

# course

cut -d '"' -f 2 access_log| cut -d ' ' -f 2 | sort | uniq -c | sort -n | tail -3

