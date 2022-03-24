#!/bin/bash
MIN_HUE_DISTANCE=40
ATTMP_WARN_THRESHOLD=7

mix () { pastel mix $*; }
paint () { pastel paint $*; }
format () { pastel format hex $*; }
darken () { pastel darken $*; }
lighten () { pastel lighten $*; }
saturate () { pastel saturate $*; }
desaturate () { pastel desaturate $*; }
textcolor () { pastel textcolor $*; }
set_lightness () { pastel set hsl-lightness $*; }
set_saturation () { pastel set hsl-saturation $*; }

diff_real () { echo "df=($1 - $2); if (df < 0) { df=df* -1}; print df" | bc -l; }

# darkest () { pastel sort-by brightness $* | pastel format hex | head -n 1; }
# lightest () { pastel sort-by brightness $* | pastel format hex | tail -n 1; }

generate_seed () {
  local attmp="${1:-1}"
  local redo=0
  pastel paint -b $WBG "STRATEGY = ${STRATEGY}"

  local randoms=( $(pastel random -n 3 -s $STRATEGY | format) )
  # declare -g "SBG=${randoms[0]}"
  # declare -g "WBG=${randoms[1]}"
  # declare -g "EBG=${randoms[2]}"

  local seeds=( SBG WBG EBG )
  for seed_id in ${!seeds[@]}; do
    local seed=${seeds[$seed_id]}

    declare -g "$seed=${randoms[$seed_id]}"

    local pre
    (( seed_id )) &&
      pre="${seeds[((seed_id - 1))]}" ||
      pre="${seeds[((${#seeds} - 1))]}"

    local curHue=$(pastel format lch-hue ${!seed})
    local preHue=$(pastel format lch-hue ${!pre})
    local diffHue; diffHue=$(diff_real "$curHue" "$preHue")
    # echo "$pre $seed ::: diffHue $diffHue"

    (( $(echo "$diffHue < $MIN_HUE_DISTANCE" | bc -l) )) && redo=1
  done
  if (( redo )); then
    ! (( attmp % ATTMP_WARN_THRESHOLD )) && prompt_confirm "failed $attmp attempts, still continue?"
    generate_seed $((++attmp))
  else
    pastel paint -b $WBG "generated after $attmp"
  fi
}

generate_palette () {
  # local ds=$(darkest $SBG $WBG $EBG)

  C00="$(set_saturation 0.08 "${SBG}" | set_lightness 0.1 | lighten 0.02 | format)"
  C08="$(set_saturation 0.08 "${SBG}" | set_lightness 0.2 | lighten 0.08 | format)"
  C07="$(set_saturation 0.08 "${SBG}" | set_lightness 0.3 | lighten 0.16 | format)"
  C15="$(set_saturation 0.08 "${SBG}" | set_lightness 0.4 | lighten 0.32 | format)"

  C01="$(mix ${SBG} Crimson   -f 0.5 | mix - PaleVioletRed     -f 0.4 | saturate 0.04 | format)"
  C02="$(mix ${SBG} Teal      -f 0.5 | mix - MediumSpringGreen -f 0.4 | saturate 0.04 | format)"
  C03="$(mix ${SBG} Yellow    -f 0.5 | mix - Coral             -f 0.4 | saturate 0.04 | format)"
  C04="$(mix ${SBG} RoyalBlue -f 0.5 | mix - DodgerBlue        -f 0.4 | saturate 0.04 | format)"
  C05="$(mix ${SBG} Orchid    -f 0.5 | mix - SlateBlue         -f 0.4 | saturate 0.04 | format)"
  C06="$(mix ${SBG} Cyan      -f 0.5 | mix - DeepSkyBlue       -f 0.4 | saturate 0.04 | format)"

  C09="$(lighten 0.10 "$C01" | format)"
  C10="$(lighten 0.10 "$C02" | format)"
  C11="$(lighten 0.10 "$C03" | format)"
  C12="$(lighten 0.10 "$C04" | format)"
  C13="$(lighten 0.10 "$C05" | format)"
  C14="$(lighten 0.10 "$C06" | format)"

  for x in C{00..15}; do export $x; done

  for s in SBG WBG EBG; do
    local key="${s:0:1}";
    declare -g "${key}FG=$(textcolor  "${!s}" | format)"
  done

  for i in {1..6}; do
    local c="C0$i"; c="${!c}"
    declare -g "CX$i=$(saturate   0.30 "$c" | darken  0.02 | format)"
    declare -g "CY$i=$(desaturate 0.30 "$c" | lighten 0.10 | format)"

    local cx="CX$i"; cx="${!cx}"
    declare -g "CF$i=$(textcolor $cx | format)"
  done
}

__gen_shade () {
  local seed="${!1}";
  local key="${1:0:1}";

  declare -g "${key}K0=$(set_saturation 0.10 "${seed}" | set_lightness 0.04 | format)"
  declare -g "${key}K1=$(set_saturation 0.11 "${seed}" | set_lightness 0.08 | format)"
  declare -g "${key}K2=$(set_saturation 0.12 "${seed}" | set_lightness 0.12 | format)"
  declare -g "${key}K3=$(set_saturation 0.13 "${seed}" | set_lightness 0.16 | format)"
  declare -g "${key}K4=$(set_saturation 0.14 "${seed}" | set_lightness 0.20 | format)"
  declare -g "${key}K5=$(set_saturation 0.14 "${seed}" | set_lightness 0.30 | format)"
  declare -g "${key}K6=$(set_saturation 0.13 "${seed}" | set_lightness 0.50 | format)"
  declare -g "${key}K7=$(set_saturation 0.12 "${seed}" | set_lightness 0.60 | format)"
  declare -g "${key}K8=$(set_saturation 0.11 "${seed}" | set_lightness 0.70 | format)"
  declare -g "${key}K9=$(set_saturation 0.10 "${seed}" | set_lightness 0.80 | format)"
}
generate_shade () {
  __gen_shade SBG
  __gen_shade WBG
  __gen_shade EBG
}
