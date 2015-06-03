# vim: set syntax=zsh:

# Path to your oh-my-zsh configuration.
DOTFILES="${HOME}/.dotfiles"
ZSH="${HOME}/.oh-my-zsh"

# Set to the name theme to load. Change it if user is SSHing.
[[ -z $SSH_CLIENT ]] && DEFAULT_USER="damon"

ZSH_THEME="dzjparty"

# Plugins
plugins=(
  autojump
  colored-man
  colorize
  command-not-found
  cp
  encode64
  extract
  git
  git-extras
  history
  rsync
  urltools
  vi-mode
  vi-history-substring
)

function source_if_exists {
  if [[ -s "${1}" ]]; then
    source "${1}"
  fi
}

# Docker
if (( $+commands[docker] )) ; then
  plugins+=('docker')
fi

source "${DOTFILES}/.env"
source "${ZSH}/oh-my-zsh.sh"

unsetopt auto_name_dirs

# Include the aliases file and anything in lib
source "${DOTFILES}/.aliases"
for local_lib ("${DOTFILES}/lib/"*) source "${local_lib}"

source_if_exists "${HOME}/.zshrc.local"
