#!/bin/bash


apply_plugins () {
  echo apply_plugins
  for plugin in $BASE_PATH/plugins/*.sh; do
    echo plugin $plugin
    . "$plugin"
    apply
  done
}

