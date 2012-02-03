# Path to your oh-my-zsh configuration.
export WORKSPACE="${HOME}/Workspace"
export ZSH="${WORKSPACE}/oh-my-zsh"

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
# export ZSH_THEME="wezm"
# export ZSH_THEME="miloshadzic"
# export ZSH_THEME="wedisagree"
export ZSH_THEME="kphoen"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Plugins
plugins=(django extract git github pip python)

source $ZSH/oh-my-zsh.sh

# Homemade Scripts
export HOMEMADE="${WORKSPACE}/dotfiles/bin"
source "${HOMEMADE}/django.sh"

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

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

unsetopt auto_name_dirs

# export ORACLE_HOME=/usr/lib/oracle/11.2/client64
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME/lib:/usr/local/lib
# export TNS_ADMIN=$ORACLE_HOME/network/admin
