#!/bin/bash

dir=`pwd`

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <der_file> <priv_file> <done_file>"
  exit 1
fi

echo "der file  = ${1}"
echo "priv file = ${2}"
echo "done file = ${3}"

for modfile in $(modinfo -n vmmon vmnet); do
  echo "Signing $modfile"
  /usr/src/linux-headers-$(uname -r)/scripts/sign-file sha256 \
                                ${2} \
                                ${1} "$modfile"
done

echo "DONE!" > ${3}
