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

__demo_format () {
  local format=${1:-hex}
  for seed in SBG WBG EBG; do
    local val=$(pastel format $format ${!seed})
    local slen=$((7-${#val}))
    local space=$(printf "%0.s " $(seq 1 "$slen"))
    pastel paint -b -n "${!seed}" "▏${val}${space}"
  done
  pastel paint $C08 "░ ${format}"
}
__demo_mxname () {
  local ulen="${#USER}"
  local mlen="${#MXNAME}"
  local vlen="${#MXC_V}"

  local flen=$((ulen+mlen+vlen+6))
  local space; space=$(printf "%0.s " $(seq 1 "$flen"))

  __fill 3
  pastel paint -b -o "${SBG}" "$(pastel textcolor "${SBG}")" "$space"
  __fill 3
  pastel paint -n -b -o "$SBG" "$SFG" " ${1:-$USER} "
  pastel paint -n -b -o "$WBG" "$WFG" " $MXNAME "
  pastel paint -n -b -o "$EBG" "$EFG" " $MXC_V "
  echo
  __fill 3
  pastel paint -b -o "${EBG}" "$(pastel textcolor "${EBG}")" "$space"
}

demo_full () {
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

  for i in {0..9}; do __print_row " " SK${i} WK${i} EK${i}; done
  echo
}

demo () {
  echo
  __fill 4; __demo_format hsl-saturation
  __fill 4; __demo_format lch-hue
  __fill 4; __demo_format lch-lightness
  __fill 4; __demo_format lch-chroma
  echo
  __demo_mxname
  echo
}
