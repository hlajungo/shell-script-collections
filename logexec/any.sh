#!/bin/bash

scriptName="$(basename "$(realpath "${BASH_SOURCE[0]}")")"
scriptDir="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
export -n scriptName
export -n scriptDir
cd $scriptDir

source color.sh
source logexec.sh


cat \
  \
  \
  \
\
t.txt

logexec $LINENO $? \
  "SUC" \
  "ERR"

