# Path to your oh-my-zsh configuration.
export WORKSPACE="${HOME}/Workspace"
export ZSH="${WORKSPACE}/oh-my-zsh"

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
alias l="ls -alh"
alias lg="l | grep"
alias grepir='grep -Ir'
alias bro='sudo apt-get'
alias mkdirs='mkdir -p'
alias ipython="ipython --colors='LightBG'"
alias dj="cd ~/Workspace/django-projects/"
alias wrk="cd ~/Workspace/"

unsetopt auto_name_dirs

# Include any files in $WORKSPACE/dotfiles/lib/*
for local_lib ($WORKSPACE/dotfiles/lib/*.*) source $local_lib

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
export PATH=$PATH:/opt/vagrant/bin:$HOME/.rvm/bin
