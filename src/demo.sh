#!/bin/bash

COLUMNS=${COLUMNS:-$(tput cols)}

__section () {
  local third=$(( $(tput cols) / 4 ))
  pastel paint -n $1 '   '
  pastel paint -n $1 $(printf "%0.s█" $(seq 1 "${third}"))
  pastel paint -n $1 ''
}
__print_head () {
  __section $SBG
  __section $WBG
  __section $EBG

  echo -e '\n\n'
  pastel paint -n $C08 $(printf "%0.s▒" $(seq 1 "${COLUMNS}"))
  echo -e '\n\n'
}

__print_hexes () {
  while [ "${1:-}" ]; do
    local tc="$(pastel textcolor "${!1}")"
    local cc="${!1}"
    # pastel paint -n -o "${!1}" "${tc}" " ${1} "
    pastel paint -n -o "#000" "${cc}" " ${cc:(-6)} "
    # printf ' '
    shift
  done
  echo
}

demo () {
  __print_head

  __print_hexes {S,W,E}BG
  __print_hexes CX{1..6}
  __print_hexes C0{1..6}
  __print_hexes CY{1..6}
  __print_hexes SK{0..9}
  __print_hexes WK{0..9}
  __print_hexes EK{0..9}
}
