#!/usr/bin/env bash

set -e

function log {
  printf '[%s] %s\n' "$(date '+%X')" "$*"
}


cd "$HOME"


# Install ohmyzsh/ohmyzsh
# https://github.com/ohmyzsh/ohmyzsh
if [[ ! -e ~/.oh-my-zsh/.git/ ]]; then
  log "Installing oh-my-zsh"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  log "Skipping oh-my-zsh install since it already exists!"
fi


# Install zplug/zplug
# https://github.com/zplug/zplug
if [[ ! -e ~/.zplug/.git/ ]]; then
  log "Installing zplug"
  git clone https://github.com/zplug/zplug ~/.zplug
else
  log "Skipping zplug install since it already exists!"
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

