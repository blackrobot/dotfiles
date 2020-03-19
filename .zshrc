# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

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
autoload -Uz \
  android-mirror \
  brewfind \
  bubu \
  cheat \
  halp \
  man
alias cbubu='clear ; bubu'
alias brinfo='brewfind'

# Add the `help` command
autoload -Uz \
  run-help \
  run-help-git \
  run-help-ip \
  run-help-openssl \
  run-help-sudo \
  run-help-svk
unalias run-help
alias help='run-help'

source "${ZSH}/oh-my-zsh.sh"

# zplug
source_dotfile ".zplugrc"


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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
