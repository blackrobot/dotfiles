# vim: set syntax=zsh:
# Path to your oh-my-zsh configuration.
DOTFILES="${HOME}/.dotfiles"
ZSH="${HOME}/.oh-my-zsh"

# Set to the name theme to load. Change it if user is SSHing.
[[ -z $SSH_CLIENT ]] && DEFAULT_USER="damon"

COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
HIST_STAMPS="yyyy-mm-dd"
ZSH_CUSTOM="${DOTFILES}/zsh.custom"

ZSH_THEME="dzjparty"

# Plugins
plugins=(
  aws
  colored-man-pages
  command-not-found
  cp
  docker-compose
  docker
  encode64
  extract
  git
  git-extras
  github
  httpie
  rsync
  urltools
  vi-mode
  vi-history-substring
  z
)

# fpath=("${DOTFILES}/zsh.plugins" $fpath)
# autoload -Uz async && async

function source_if_exists {
  if [[ -s "${1}" ]]; then
    source "${1}"
  fi
}

source_if_exists "${DOTFILES}/.env"
source "${ZSH}/oh-my-zsh.sh"

unsetopt auto_name_dirs

export LESS="-R --ignore-case --tabs=4"

# Include the aliases file and anything in lib
source "${DOTFILES}/.aliases"
for local_lib ("${DOTFILES}/lib/"*) source "${local_lib}"

source_if_exists "${HOME}/.fzf.zsh"
source_if_exists "${HOME}/.zshrc.local"
