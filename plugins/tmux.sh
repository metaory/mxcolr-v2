#!/bin/bash

# check https://github.com/metaory/tmux-mxc for tmux theme

apply () {
  ! [ "$TMUX" ] && echo NOTMUX && return

  local socket="$(tmux display -p "#{b:socket_path}")"
  tmux -L "$socket"  run-shell "tmux source-file ~/.config/mxc-v2/tmux.mx"
  tmux -L "$socket"  run-shell "tmux source-file ~/.config/tmux/meta.min.tmuxtheme"
}

