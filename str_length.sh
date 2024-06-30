#!/bin/bash
if [[ -z "$1" ]]
  then
    echo "No string provided."
  else
    STRING=$1
    LENGTH=${#STRING}
    echo $LENGTH
fi
