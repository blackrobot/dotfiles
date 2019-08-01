# Path to your oh-my-zsh configuration.
ZSH="${HOME}/.oh-my-zsh"

# Set to the name theme to load. Change it if user is SSHing.
[[ -z "$SSH_CLIENT" ]] && DEFAULT_USER="damon"

COMPLETION_WAITING_DOTS=true
DISABLE_UNTRACKED_FILES_DIRTY=true
DISABLE_UPDATE_PROMPT=true
DISABLE_AUTO_UPDATE=true
ZSH_COMPDUMP="${HOME}/.zcompdump"
ZSH_CUSTOM="${DOTFILES}/zsh.custom"

# async suggestions
ZSH_AUTOSUGGEST_USE_ASYNC=1

# set to blank string for pure prompt
ZSH_THEME=""

# Plugins
plugins=(
  # aws
  # colored-man-pages
  # command-not-found
  # cp
  # docker-compose
  # docker
  # encode64
  # extract
  # git
  # git-extras
  # github
  # httpie
  # rsync
  # vi-mode
  vi-history-substring
  # yarn
  # z
  # zsh-nvm
  # zsh-autosuggestions
)

function source_if_exists {
  source "$1" 2>/dev/null || true
}

function source_dotfile {
  source "${DOTFILES}/${1}"
}

# oh-my-zsh opts
DISABLE_CORRECTION=1
HIST_IGNORE_SPACE=1
HIST_STAMPS="yyyy-mm-dd"

fpath=( "${DOTFILES}/zfuncs" "${fpath[@]}" )

# Register functions for autoloading
autoload -Uz bubu cheat halp man
alias cbubu='clear ; bubu'

# Add the `help` command
autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz run-help-ip
autoload -Uz run-help-openssl
autoload -Uz run-help-sudo
autoload -Uz run-help-svk
unalias run-help
alias help='run-help'

source "${ZSH}/oh-my-zsh.sh"

# zplug
source_dotfile ".zplugrc"

# zsh opts
setopt hist_ignore_all_dups
setopt hist_find_no_dups
setopt hist_save_no_dups
setopt hist_reduce_blanks
unsetopt auto_name_dirs

# less options
export LESS='-R --ignore-case --tabs=4'

# bat options | https://github.com/sharkdp/bat
export BAT_THEME='OneHalfDark'

# fzf
source_dotfile ".fzfrc"

source_dotfile ".aliases"
source_dotfile "lib-includes"

source_if_exists "${HOME}/.zshrc.local"

# Update stuff in the background
{
  if (( $+commands[tldr] )); then
    tldr --update > /dev/null 2>&1
  fi

  ##
  # Compile completion dumped files
  # https://htr3n.github.io/2018/07/faster-zsh/#compiling-completion-dumped-files
  ##

  # Compile zcompdump, if modified, to increase startup speed.
  zcompdump="$ZSH_COMPDUMP"

  if [[ -z "$zcompdump" ]]; then
    zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  fi

  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi

} &!
