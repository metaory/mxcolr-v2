#!/bin/bash

__print_key () {
  local len=${#1}
  local key="${1:0:1}";
  local label="${1:1:$len}";
  pastel paint -n $WBG "[$key]"
  pastel paint -n $EBG "$label "
}

prompt_menu () {
  pastel paint -n $SBG "Select "
  __print_key update
  __print_key next
  __print_key demo
  read -n 1 -r -s
  echo
}
