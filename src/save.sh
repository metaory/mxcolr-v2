#!/bin/bash
ALACRITTY_SOCKET=${ALACRITTY_SOCKET:-}
TMUX=${TMUX:-}

save () {
  mkdir out 2> /dev/null || true

  for file in $BASE_PATH/templates/*; do
    local out="./out/$(basename $file)"
    envsubst < "$file" | tee $out 1>/dev/null
    echo " ::> $out"
  done

  cp out/* ~/.config/mxc-v2 -fv
}

save_preview_terminal () {
  [[ -n "$TMUX" ]] &&
    echo preview_tmux; # TODO <<<

  [[ -n "${ALACRITTY_SOCKET}" ]] &&
    rm ~/.config/mxc-v2/alacritty.yml &&
    envsubst < $BASE_PATH/templates/alacritty.yml > ~/.config/mxc-v2/alacritty.yml

  return 0
}
