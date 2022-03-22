#!/bin/bash

apply () {
  cp -v ./out/vim-visual-multi_themes.vim ~/.local/share/nvim/site/pack/packer/opt/vim-visual-multi/autoload/vm/themes.vim
  cp -v ./out/palette.lua ~/.config/nvim/lua/mxc/palette.lua
  cp -v ./out/mxc-nvim-base16.lua ~/.config/nvim/lua/mxc
  cp -v ./out/mxc-nvim-colors.lua ~/.config/nvim/lua/mxc
}
