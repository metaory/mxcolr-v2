#!/bin/bash

# logv () { while [ "${1:-}" ]; do echo "${1} (${!1})"; shift; done; }

__print_hexes () {
  while [ "${1:-}" ]; do
    local tc="$(pastel textcolor "${!1}")"
    local cc="${!1}"
    pastel paint -n -o "${!1}" "${tc}" "${1} "
    pastel paint -n -o "#000" "${cc}" "${cc:(-6)}"
    # printf ' '
    shift
  done
  echo
}

demo () {
  __print_hexes {S,W,E}BG
  __print_hexes CX{1..6}
  __print_hexes C0{1..6}
  __print_hexes CY{1..6}
  __print_hexes SK{0..9}
  __print_hexes WK{0..9}
  __print_hexes EK{0..9}
}
