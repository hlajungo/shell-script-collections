#!/bin/bash

parentScriptName="$(basename "$(realpath "${BASH_SOURCE[1]}")")"
parentScriptDir="$(dirname "$(realpath "${BASH_SOURCE[1]}")")"

source "color.sh"

logexec()
{
  cmdStr=()
  local backNLine=0
  
  # track to first not empty line
  while [[ -z $(awk "NR==$1-$backNLine {print prev} {prev=\$0}" "$parentScriptDir/$parentScriptName") ]]
  do
    backNLine=$(($backNLine+1))
  done

  # 如果上上行是 "\" 結尾的，推入 cmdStr
  while [[ "$(awk "NR==$1-$backNLine-1 {print prev} {prev=\$0}" "$parentScriptDir/$parentScriptName")" == *"\\" ]]; do
    cmdStr+=("$(awk "NR==$1-$backNLine {print prev} {prev=\$0}" "$parentScriptDir/$parentScriptName")")
    backNLine=$(($backNLine+1))
  done
  
  # 輸出最後一行
  color yellow "$(awk "NR==$1-$backNLine {print prev} {prev=\$0}" "$parentScriptDir/$parentScriptName")"

  # 吐出 cmdStr
  while [[ ${#cmdStr[@]} -ne 0 ]]; do
    color yellow "${cmdStr[-1]}"
    unset cmdStr[-1]
  done

  if [ $2 -eq 0 ]; then
    color green "$3"
  else
    color red "$4"
  fi
}

