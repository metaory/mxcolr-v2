#!/bin/bash
ALACRITTY_SOCKET=${ALACRITTY_SOCKET:-}
TMUX=${TMUX:-}
MXC_V=v2.0.0
MXNAME=MXC

save () {
  mkdir out 2> /dev/null || true

  command -v bullshit &> /dev/null \
    && MXNAME="$(bullshit | cut -d' ' -f1 | cut -d'-' -f1)"

  for file in $BASE_PATH/templates/*; do
    local out="./out/$(basename $file)"
    envsubst < "$file" | tee $out 1>/dev/null
  done

  cp out/* ~/.config/mxc-v2 -f
}

save_preview_terminal () {
  # ! [ "$TMUX" ] && echo NOTMUX && return
  if [ "$TMUX" ]; then
    echo TODO::preview_tmux; # TODO <<<
    . $BASE_PATH/plugins/tmux.sh
    apply
  fi

  if [ "${ALACRITTY_SOCKET}" ]; then
    rm ~/.config/mxc-v2/alacritty.yml
    envsubst < $BASE_PATH/templates/alacritty.yml > ~/.config/mxc-v2/alacritty.yml
  fi

  return 0
}
