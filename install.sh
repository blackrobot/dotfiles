#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Install the pre-requisites
sudo apt-get install ruby-dev rake exuberant-ctags ack-grep zsh xclip vim

# Install janus
rm -rf "${HOME}/.vim" "${HOME}/.vimrc"
ln -s "${DIR}/janus/" "${HOME}/.vim"
cd "${HOME}/.vim/" && rake
ln -s "${DIR}/.janus/" "${HOME}"
ln -s "${DIR}/.vimrc.before" "${HOME}"
ln -s "${DIR}/.vimrc.after" "${HOME}"

# Install zsh
ln -s "${DIR}/.zshrc" "${HOME}"
chsh -s /bin/zsh

# Fonts and Git
ln -s "${DIR}/.fonts/" "${HOME}"
ln -s "${DIR}/.gitconfig" "${HOME}"

# Reset the font cache
sudo fc-cache -fv
