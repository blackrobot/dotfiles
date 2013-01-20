# vim: set syntax=sh:

# Path to your oh-my-zsh configuration.
export WORKSPACE="${HOME}/Workspace"
export DOTFILES="${WORKSPACE}/dotfiles"
export ZSH="${HOME}/.oh-my-zsh"

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="kphoen"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Plugins
plugins=(django extract git github pip python)

source $ZSH/oh-my-zsh.sh

# virtualenv, pip, and python
export WORKON="${HOME}/.virtualenvs"
source /usr/local/bin/virtualenvwrapper.sh
export PIP_VIRTUALENV_BASE=$WORKON_HOME
export PIP_RESPECT_VIRTUALENV=true

alias man="TERMINFO=~/.terminfo LESS=C TERM=mostlike PAGER=less man"
source "${HOME}/.aliases"

unsetopt auto_name_dirs

# Include any files in $WORKSPACE/dotfiles/lib/*
for local_lib ($DOTFILES/lib/*.*) source $local_lib

# Vim for the win!
export EDITOR="vim"

# Use custom dircolors
export TERM="xterm-256color"
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

# Fix prompt for Tmux
PROMPT="$PROMPT"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#D" | tr -d %) "$PWD")'

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Path modifications for Heroku and RVM
export PATH="/usr/local/heroku/bin:$PATH:$HOME/.rvm/bin"
