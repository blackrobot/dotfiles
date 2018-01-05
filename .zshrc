# Path to your oh-my-zsh configuration.
ZSH="${HOME}/.oh-my-zsh"

# Set to the name theme to load. Change it if user is SSHing.
[[ -z "$SSH_CLIENT" ]] && DEFAULT_USER="damon"

COMPLETION_WAITING_DOTS=true
DISABLE_UNTRACKED_FILES_DIRTY=true
DISABLE_UPDATE_PROMPT=true
ZSH_CUSTOM="${DOTFILES}/zsh.custom"

# async suggestions
ZSH_AUTOSUGGEST_USE_ASYNC=1

# set to blank string for pure prompt
ZSH_THEME=""

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
  zsh-nvm
  zsh-autosuggestions
)

autoload -U compinit && compinit

function source_if_exists {
  if [[ -s "$1" ]]; then
    source "$1"
  fi
}

# oh-my-zsh opts
DISABLE_CORRECTION=1
HIST_IGNORE_SPACE=1
HIST_STAMPS="yyyy-mm-dd"

source "${ZSH}/oh-my-zsh.sh"

# zsh opts
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_save_no_dups
setopt hist_reduce_blanks
unsetopt auto_name_dirs

# pure theme setup
fpath=( "${DOTFILES}/zsh.plugins" $fpath )
autoload -U promptinit ; promptinit
prompt pure

# less options
LESS='-R --ignore-case --tabs=4'

source "${DOTFILES}/.aliases"
source "${DOTFILES}/lib-includes"

source_if_exists "${HOME}/.fzf.zsh"
source_if_exists "${HOME}/.zshrc.local"
