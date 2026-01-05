# shellcheck shell=bash disable=SC2034

# Set default user for prompt (hide user@host when not SSHing)
[[ -z "$SSH_CLIENT" ]] && DEFAULT_USER="damon"

##
# Helper functions
##

function filepath_exists {
  [[ -f "$1" || -d "$1" ]]
}

function source_if_exists {
  # shellcheck source=/dev/null
  source "$1" 2>/dev/null || true
}

function source_dotfile {
  # shellcheck source=/dev/null
  source "${DOTFILES}/${1}"
}

##
# Pre-plugin setup
##

# zsh-autosuggestions config (must be set before loading plugin)
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#888888'
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20

# forgit config
export FORGIT_NO_ALIASES=1
export FORGIT_FZF_DEFAULT_OPTS="--layout=reverse"

# fpath for custom functions and completions
fpath=( "${DOTFILES}/zfuncs" "${fpath[@]}" )
export FPATH="${HOMEBREW_PREFIX}/share/zsh/functions:$FPATH"

# Register functions for autoloading
autoload -Uz \
  android-mirror \
  brewfind \
  bubu \
  cheat \
  fprev \
  halp \
  opstream \
  man
alias cbubu='clear ; bubu'
alias resesh='reset ; bubu && exec "$SHELL"'
alias brinfo='brewfind'

# Add the `help` command
autoload -Uz \
  run-help \
  run-help-git \
  run-help-ip \
  run-help-openssl \
  run-help-sudo \
  run-help-svk
unalias run-help 2>/dev/null
alias help='run-help'

##
# Completion system (must be before plugins that use compdef)
##

# Set cache dir for oh-my-zsh plugins that need it
ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
[[ -d "$ZSH_CACHE_DIR/completions" ]] || mkdir -p "$ZSH_CACHE_DIR/completions"

# Initialize completion system
autoload -Uz compinit
compinit -d "${ZSH_CACHE_DIR}/zcompdump"

##
# Antidote plugin manager
# https://antidote.sh/
##

ANTIDOTE_HOME="${HOME}/.antidote"
if [[ ! -d "$ANTIDOTE_HOME" ]]; then
  git clone --depth=1 https://github.com/mattmc3/antidote.git "$ANTIDOTE_HOME"
fi
source "${ANTIDOTE_HOME}/antidote.zsh"
antidote load "${DOTFILES}/.zsh_plugins.txt"

##
# Post-plugin setup
##

# History substring search keybindings
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# Zoxide (smarter directory jumping)
eval "$(zoxide init zsh)"


##
# zsh opts | http://zsh.sourceforge.net/Doc/Release/Options.html
##

## zsh opts > history
HISTSIZE=$(( 10 ** 7 ))         # 10 million lines of history in file
SAVEHIST=$(( 10 ** 6 ))         # 1 million lines of history in mem
setopt BANG_HIST                # expand '!' in history
setopt EXTENDED_HISTORY         # save timestamp and duration
setopt HIST_EXPIRE_DUPS_FIRST   # rm dupes before unique cmds
setopt HIST_FCNTL_LOCK          # use os locking of history file
setopt HIST_FIND_NO_DUPS        # don't diplay dupes when searching
setopt HIST_IGNORE_DUPS         # don't add cmds to history if dupes of previous
setopt HIST_IGNORE_SPACE        # don't add cmds that start with a space
setopt HIST_NO_STORE            # don't store the `history` command itself
setopt HIST_REDUCE_BLANKS       # see doc
setopt HIST_VERIFY              # show the history cmd without executing
setopt INC_APPEND_HISTORY       # cmds are recorded in order of execution
setopt SHARE_HISTORY            # see doc
# NOTE: This can be slow!
# setopt HIST_LEX_WORDS         # correctly handle whitespace

## zsh opts > completion
setopt ALWAYS_TO_END            # move cursor to end after completing word
setopt AUTO_LIST
setopt AUTO_MENU                # use menu after pressing `tab` twice
setopt AUTO_PARAM_KEYS
setopt COMPLETE_IN_WORD
setopt LIST_TYPES
setopt NO_AUTO_NAME_DIRS        # UNSET "~dir" aliasing

## zsh opts > changing directories
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

## zsh opts > input/output
setopt INTERACTIVE_COMMENTS     # allow comments in interactive shell
setopt NO_FLOW_CONTROL          # UNSET

##
# /zsh opts
##


# less options
export LESS='-R --ignore-case --tabs=4'

# bat options | https://github.com/sharkdp/bat
export BAT_THEME="Dracula"

# fzf
source_dotfile ".fzfrc"

source_dotfile ".aliases"
source_dotfile "lib-includes"

source_if_exists "${HOME}/.zshrc.local"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# shellcheck source=.p10k.zsh disable=SC1094
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Include antigravity if installed
if filepath_exists "${HOME}/.antigravity/antigravity/bin"; then
  export PATH="${HOME}/.antigravity/antigravity/bin:${PATH}"
fi
