#!/usr/bin/env bash

set -e


VSCODE_SETTINGS_DIR="${HOME}/Library/Application Support/Code/User"

VSCODE_SETTINGS="${VSCODE_SETTINGS_DIR}/settings.json"
VSCODE_KEYBINDINGS="${VSCODE_SETTINGS_DIR}/keybindings.json"

if [[ -L "$VSCODE_SETTINGS" ]] ; then
  echo "${VSCODE_SETTINGS} symlink already exists -- aborting!"
  exit 1
fi

if [[ -L "$VSCODE_KEYBINDINGS" ]] ; then
  echo "${VSCODE_KEYBINDINGS} symlink already exists -- aborting!"
  exit 1
fi

timestamp="$(date '+%Y%m%d_%H%M%S')"
(
  set -x
  mv "$VSCODE_SETTINGS" "${VSCODE_SETTINGS}.bak-${timestamp}.json" &&
  ln -s "${DOTFILES}/vs-code/settings.json" "${VSCODE_SETTINGS}" &&
  mv "$VSCODE_KEYBINDINGS" "${VSCODE_KEYBINDINGS}.bak-${timestamp}.json" &&
  ln -s "${DOTFILES}/vs-code/keybindings.json" "$VSCODE_KEYBINDINGS"
)

printf 'Settings are now linked in "%s": \n' "$VSCODE_SETTINGS_DIR"
(
  cd "$VSCODE_SETTINGS_DIR" &&
  ls -AlhF --color=always '*.json' &&
  echo
)
