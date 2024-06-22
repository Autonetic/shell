#!/bin/bash
if [[ -z "$1" ]]
  then
    echo "No encryption/decryption method specified."
elif [[ -z "$2" ]]
  then
    echo "No string has been provided..."
else
  if [[ -z "$3" ]]
  then
    echo "No password specified."
  fi
fi

if [[ $1 == "decrypt" ]]
  then
    echo $2 | openssl aes-256-cbc -pbkdf2  -d -a -pass pass:$3
elif [[ $1 == "encrypt" ]]
  then
    echo $2 | openssl aes-256-cbc -pbkdf2 -a -salt -pass pass:$3
else
  echo "Unrecognised argument $1"
fi
