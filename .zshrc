# vim: set syntax=zsh:

# Path to your oh-my-zsh configuration.
DOTFILES="${HOME}/.dotfiles"
ZSH="${HOME}/.oh-my-zsh"

# Set to the name theme to load. Change it if user is SSHing.
# Look in ~/.oh-my-zsh/themes/
[[ -z $SSH_CLIENT ]] && DEFAULT_USER="damon"

ZSH_THEME="dzj"

# Plugins
plugins=(
  autojump
  colored-man
  colorize
  command-not-found
  cp
  encode64
  extract
  gem
  git
  git-extras
  history
  npm
  pip
  rsync
  urltools
)

# Virtualenv & Virtualenv Wrapper
if [[ -d $HOME/.virtualenvs ]]; then
  export WORKON=$HOME/.virtualenvs
  export PIP_VIRTUALENV_BASE=$WORKON
  export PIP_RESPECT_VIRTUALENV=true
  plugins+=('virtualenv')
  if [[ -s /usr/local/bin/virtualenvwrapper.sh ]]; then
    source /usr/local/bin/virtualenvwrapper.sh
    plugins+=('virtualenvwrapper')
  fi
fi

# Docker
if (( $+commands[docker] )) ; then
  plugins+=('docker')
fi

# RVM
if (( $+commands[rvm] )) ; then
  plugins+=('rvm')
fi

DISABLE_CORRECTION=true

source $ZSH/oh-my-zsh.sh

unsetopt auto_name_dirs

# Include the aliases file and anything in lib
source $DOTFILES/.aliases
for local_lib ($DOTFILES/lib/*) source $local_lib

# Use custom dircolors
export TERM="xterm-256color"
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Vim
export EDITOR="vim"

# Load .zshrc.local if it exists
if [[ -s $HOME/.zshrc.local ]]; then
  source $HOME/.zshrc.local
fi
