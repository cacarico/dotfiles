#!/usr/bin/env fish

set -x FZF_DEFAULT_OPTS "\
    --color=spinner:#f4dbd6,hl:#c6a0f6 \
    --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
    --color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#c6a0f6"

set -x FZF_CTRL_T_OPTS "\
    --preview 'bat -n --color=always {}' \
    --bind 'ctrl-/:change-preview-window(down|hidden|)'"
