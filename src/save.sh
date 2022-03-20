#!/bin/bash

save () {
  mkdir out 2> /dev/null || true

  for file in $BASE_PATH/templates/*; do
    local out="./out/$(basename $file)"
    envsubst < "$file" | tee $out 1>/dev/null
    echo " ::> $out"
  done

  cp out ~/.config/mxc-v2 -rv
}
