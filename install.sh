#!/usr/bin/env bash
# vim: set syntax=sh:

set -e

echo ''

# Colors :)
bold="$(tput bold)"
reset="$(tput sgr0)"
red="$(tput setaf 1)"
yellow="$(tput setaf 3)"
green="$(tput setaf 2)"

function message {
  echo -e "${bold}${1}[${2}]${reset}\t\t${bold}${3}${reset}"
}

function fail {
  message $red "FAIL" $1
  echo ''
  exit
}

function success {
  message $green "OK" $1
}

function warn {
  local hashes=$(head -c (${#1} + 4) < /dev/zero | tr '\0' '#')
  echo -e "\n${hashes}\n# ${bold}${yellow}${1}${reset} #\n${hashes}"
}

# Sets the current directory to $DIR
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function download {
  # Download the url passed as an argument and install it
  curl -L ${1} | sh
}

function link {
  ln -s "${DIR}/${1}" "${HOME}"
}

function install_janus {
  local pre_reqs="ruby-dev rake exuberant-ctags ack-grep zsh xclip vim"
  local url="https://bit.ly/janus-bootstrap"

  warn "Installing Janus"

  # Install the pre-requisites
  sudo apt-get install $pre_reqs &&

  # Delete existing vim files
  rm -rf "${HOME}/.vim" "${HOME}/.vimrc" &&

  # Download and install using the janus boostrap script
  download $url &&

  # Symlink janus and vim configuration files
  link ".janus/" &&
  link ".vimrc.before" &&
  link ".vimrc.after" &&

  success "Installed Janus" || fail "Could not install Janus"
}

function install_tmux {
  warn "Installing Tmux"

  # Install the package
  sudo apt-get install tmux &&

  # Symlink the config
  link ".tmux.conf" &&
  link ".tmux-powerlinerc" &&

  success "Installed Tmux" || fail "Could not install Tmux"
}

function install_zsh {
  local url="https://goo.gl/1DRPI"

  warn "Installing ZSH"

  # Download and install using the oh-my-zsh bootstrap script
  download $url &&

  # Substitude the default .zshrc for our customized one
  rm -f "${HOME}/.zshrc" &&
  link ".zshrc" &&

  # Set this user's default shell to ZSH
  chsh -s /bin/zsh &&

  success "Installed ZSH" || fail "Could not install ZSH"
}

function install_extra {
  warn "Setting up fonts and config files"

  # Create the symlinks
  link ".fonts/" &&
  link ".gitconfig" &&

  # Reset the font cache
  sudo fc-cache -fv
}

function install_dircolors {
  local gconf="${HOME}/.gconf/apps/gnome-terminal/profiles"

  warn "Installing Dircolors"

  if [ -d $gconf ]; then
    mkdir "${gconf}/Blackrobot" &&
    ln -s "${DIR}/gnome/%gconf.xml" "${gconf}/Blackrobot/"
  fi

  link ".dircolors" &&
  eval $(dircolors -b "${DIR}/.dircolors") &&

  success "Installed Dircolors" || fail "Could not install Dircolors"
}

if [ "${1}" == "server" ]; then
  install_janus
  install_tmux
  install_extra

elif [ "${1}" == "local" ]; then
  install_janus
  install_zsh
  install_tmux
  install_dircolors
  install_extra

else
  echo "Please specify the packages to install:"
  echo -e "\t ${bold}local${reset}  => Installs everything."
  echo -e "\t ${bold}server${reset} => Installs everything except for fonts, zsh, and gnome/dircolors."
  exit

fi
