#!/usr/bin/env zsh

PET_PREVIEW_COMMAND="$(cat <<'EOF'
  echo {} \
    | rg --only-matching '^\[(.+?)\]:\s*(.+)' --replace '$2' \
    | bat --wrap auto --paging never --language sh --style plain --color always
EOF
)"

if [[ $(tput cols) -lt 95 ]]; then
  PET_PREVIEW_WINDOW="down:3:wrap"
else
  PET_PREVIEW_WINDOW="right:60%:wrap"
fi

##
# This is the `fzf` command used by `pet` to display and select a snippet. It should
# be used as the value for the `selectcmd` setting in ~/.config/pet/config.toml
# https://github.com/knqyf263/pet/tree/cb749abdb17103af96499a6bd5d26774402beff6#selector-option
#
#     selectcmd = '_fzf::pet-list'
##
fzf --ansi \
    --height 15% \
    --layout reverse-list \
    --color dark \
    --inline-info \
    --preview-window "$PET_PREVIEW_WINDOW" \
    --preview "$PET_PREVIEW_COMMAND"
