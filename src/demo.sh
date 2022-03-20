#!/bin/bash

COLUMNS=${COLUMNS:-$(tput cols)}

__section () {
  local third=$(( $(tput cols) / 4 ))
  pastel paint -n $1 '   '
  pastel paint -n $1 $(printf "%0.s█" $(seq 1 "${third}"))
  pastel paint -n $1 ''
}
__fill ()  { printf "%0.s${2:- }" $(seq 1 "${1:-0}"); }

__print_logo () {
  pastel paint -n $SBG "▄▄█"
  pastel paint -n $WBG "██"
  pastel paint -n $EBG "█▀▀"
  echo
}

__print_head () {
  __section $SBG
  __section $WBG
  __section $EBG

  echo -e '\n\n'
  pastel paint -n $C08 $(printf "%0.s▒" $(seq 1 "${COLUMNS}"))
  echo -e '\n\n'
}


__print_row () {
  local char=$1
  shift
  while [ "${1:-}" ]; do
    local tc="$(pastel textcolor "${!1}")"
    local cc="${!1}"
    [[ "$char" == ' ' ]] && char=" ${cc:(-6)} "
    pastel paint -n -o "#000" "${cc}" " $char "
    shift
  done
  echo
}

demo () {
  __print_head

  __fill 9;  __print_logo

  __fill 10; __print_row ● {S,W,E}BG
  __fill 6;  __print_row ● CX{1..6}
  __fill 6;  __print_row ● C0{1..6}
  __fill 6;  __print_row ● CY{1..6}
  __fill 1;  __print_row ● SK{0..9}
  __fill 1;  __print_row ● WK{0..9}
  __fill 1;  __print_row ● EK{0..9}

  __print_row " " {S,W,E}BG
  __print_row " " CX{1..6}
  __print_row " " C0{1..6}
  __print_row " " CY{1..6}
  echo
  for i in {0..9}; do __print_row " " SK${i} WK${i} EK${i}; done
}
