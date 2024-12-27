#!/bin/bash

scriptName="$(basename "$(realpath "${BASH_SOURCE[0]}")")"
scriptDir="$(dirname "$(realpath "${BASH_SOURCE[0]}")")"
cd $scriptDir

source color.sh

logexec()
{
  cmdStr=()
  local backNLine=0
  
  # track to first not empty line
  while [[ -z $(awk "NR==${BASH_LINENO[0]}-$backNLine {print prev} {prev=\$0}" "$scriptDir/$scriptName") ]]
  do
    backNLine=$(($backNLine+1))
  done

  # 如果上上行是 "\" 結尾的，推入 cmdStr
  while [[ "$(awk "NR==${BASH_LINENO[0]}-$backNLine-1 {print prev} {prev=\$0}" "$scriptDir/$scriptName")" == *"\\" ]]; do
    cmdStr+=("$(awk "NR==${BASH_LINENO[0]}-$backNLine {print prev} {prev=\$0}" "$scriptDir/$scriptName")")
    backNLine=$(($backNLine+1))
  done
  
  # 輸出最後一行
  color yellow "$(awk "NR==${BASH_LINENO[0]}-$backNLine {print prev} {prev=\$0}" "$scriptDir/$scriptName")"

  # 吐出 cmdStr
  while [[ ${#cmdStr[@]} -ne 0 ]]; do
    color yellow "${cmdStr[-1]}"
    unset cmdStr[-1]
  done

  if [ $1 -eq 0 ]; then
    color green "$2"
  else
    color red "$3"
  fi
}

cat t.txt

logexec $? \
  "SUC" \
  "ERR"
