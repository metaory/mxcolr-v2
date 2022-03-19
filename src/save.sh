#!/bin/bash

save () {
  mkdir out 2> /dev/null || true

  for file in $_base_path/templates/*; do
    local out="./out/$(basename $file)"
    envsubst < "$file" | tee $out 1>/dev/null
    echo " ::> $out"
  done
}
