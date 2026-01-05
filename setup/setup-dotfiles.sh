#!/usr/bin/env bash

set -e

function log {
  printf '[%s] %s\n' "$(date '+%X')" "$*"
}


cd "$HOME"


# Install antidote plugin manager
# https://github.com/mattmc3/antidote
if [[ ! -e ~/.antidote/.git/ ]]; then
  log "Installing antidote"
  git clone --depth=1 https://github.com/mattmc3/antidote.git ~/.antidote
else
  log "Skipping antidote install since it already exists!"
fi


# Install zoxide (smarter directory jumping)
# https://github.com/ajeetdsouza/zoxide
if ! command -v zoxide &> /dev/null; then
  log "Installing zoxide"
  brew install zoxide
else
  log "Skipping zoxide install since it already exists!"
fi


# Symlink everything
log "Symlinking dotfiles and dotdirs"
ln -sf dotfiles/.gitconfig
ln -sf dotfiles/.hammerspoon
ln -sf dotfiles/.jupyter
ln -sf dotfiles/.p10k.zsh
ln -sf dotfiles/.ptpython
ln -sf dotfiles/.vimrc
ln -sf dotfiles/.zlogin
ln -sf dotfiles/.zshenv
ln -sf dotfiles/.zshrc


# Make ~/.config/nvim
log "Making ~/.config/nvim symlinks"
mkdir -vp ~/.config
ln -sf ~/dotfiles/.config/nvim ~/.config/


##
# Setup vim stuff
##

# Vim Plug
# https://github.com/junegunn/vim-plug#neovim
curl -fLo \
  "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim \
  --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

