# vim: set syntax=zsh:

# Path to your oh-my-zsh configuration.
export DOTFILES="${HOME}/.dotfiles"
ZSH="${HOME}/.oh-my-zsh"

# Set to the name theme to load. Change it if user is SSHing.
[[ -z "$SSH_CLIENT" ]] && DEFAULT_USER="damon"

COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY=true
DISABLE_UPDATE_PROMPT=true
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
  yarn
  z
)

autoload -U compinit && compinit

function source_if_exists {
  if [[ -s "$1" ]]; then
    source "$1"
  fi
}

function add_to_path {
  # Adds $1 to $PATH if not already there. Add 'after'
  # as an arg to append, the default is to prepend.
  if [[ ":${PATH}:" != *":${1}:"* ]]; then
    if [[ "$2" == "append" ]]; then
      PATH="${PATH}:${1}"
    else
      PATH="${1}:${PATH}"
    fi
  fi
}

export EDITOR='vim'
DISABLE_CORRECTION=1
HIST_IGNORE_SPACE=1

source "${ZSH}/oh-my-zsh.sh"

unsetopt auto_name_dirs

export LESS="-R --ignore-case --tabs=4"

source "${DOTFILES}/.aliases"

# Only include files without a leading underscore
for local_lib in $(find ~/.dotfiles/lib -maxdepth 1 -type f ! -name '_*'); do
  source "${local_lib}"
done

source_if_exists "${HOME}/.fzf.zsh"
source_if_exists "${HOME}/.zshrc.local"
