#!/bin/bash

# Colors :)
bold="$(tput bold)"
reset="$(tput sgr0)"
red="$(tput setaf 1)"
yellow="$(tput setaf 3)"
green="$(tput setaf 2)"

function message {
  echo "---\n${bold}${1}${reset}"
}

function error {
  message "${red}${1}"
  exit
}

function success {
  message "${green}${1}"
}

function warn {
  message "${yellow}${1}"
}

# Sets the current directory to $DIR
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function get_and_install {
  # Download the url passed as an argument and install it
  curl -L ${1} | sh
}

function install_janus {
  local pre_reqs="ruby-dev rake exuberant-ctags ack-grep zsh xclip vim"
  local url="https://bit.ly/janus-bootstrap"

  warn "Installing Janus"
  # Install the pre-requisites
  sudo apt-get install $pre_reqs
  # Delete existing .vim files
  rm -rf "${HOME}/.vim" "${HOME}/.vimrc"
  # Download and install using the janus boostrap script
  get_and_install $url
  # Symlink janus and vim configuration files
  ln -s "${DIR}/.janus/" "${HOME}"
  ln -s "${DIR}/.vimrc.before" "${HOME}"
  ln -s "${DIR}/.vimrc.after" "${HOME}"
}

function install_zsh {
  local url="https://goo.gl/1DRPI"

  warn "Installing ZSH"
  # Download and install using the oh-my-zsh bootstrap script
  get_and_install $url
  # Substitude the default .zshrc for our customized one
  rm -f "${HOME}/.zshrc"
  ln -s "${DIR}/.zshrc" "${HOME}"
  # Set this user's default shell to ZSH
  chsh -s /bin/zsh
}

function install_extra {
  warn "Setting up fonts and config files"

  # Create the symlinks
  ln -s "${DIR}/.fonts/" "${HOME}"
  ln -s "${DIR}/.gitconfig" "${HOME}"
  # Reset the font cache
  sudo fc-cache -fv
}


# Install Janus
install_janus && \
  success "Installed Janus" || \
  error "Could not install Janus"

# Install ZSH
install_zsh && \
  success "Installed ZSH" || \
  error "Could not install ZSH"

# Install extras
install_extra && \
  success "Installed fonts and config files" || \
  error "Could not install fonts and config files"
