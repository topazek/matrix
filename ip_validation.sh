#!/bin/bash

# Script performs IP valiation
# Run the script using #ip_to_validation file - where the file is the file name

function PORTvalidation()
{
  if [[ ! $1 -lt 61000 && $1 -gt 0 ]]; then
    echo "Port server $1 is not valid -> the port range is 1-61000."
  else
    echo "Port server $1 is valid -> the port range is 1-61000."
  fi
}

function IPvalidation()
{
  local octet='([1-9]?[0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])'

  if [[ $1 =~ ^$octet\.$octet\.$octet\.$octet$ ]]; then
    echo "IP address $1 is a valid IP address."
  else
    echo "Sorry, IP address $1 is not a valid IP address."
    exit 1
  fi
}

# Checking service port range 1-61000
port=$(grep -m 1 ^server_port /root/info | cut -d "\"" -f 2)
echo "1. Checking port server range."
PORTvalidation $port

# Checking IP validation
IPs=$(grep -m 1 ^ip_to_check /root/info | cut -d "\"" -f 2)
echo "2. Validation IP addresses."
for ip in $IPs; do
  IPvalidation $ip
done