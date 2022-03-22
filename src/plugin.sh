#!/bin/bash

plugins_apply () {
  echo apply_plugins
  for plugin in $BASE_PATH/plugins/*.sh; do
    prompt_confirm "${plugin##*/}"
    . "$plugin"
    apply
  done
}

