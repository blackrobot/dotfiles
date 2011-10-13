# Path to your oh-my-zsh configuration.
export ZSH=$HOME/Workspace/oh-my-zsh

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="wezm"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"


# Plugins
plugins=(django extract git github pip python)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export WORKON="~/.virtualenvs"
source /usr/local/bin/virtualenvwrapper.sh

alias man="TERMINFO=~/.terminfo LESS=C TERM=mostlike PAGER=less man"
alias l="ls -alh"
alias lg="l | grep "
alias grepir='grep -Ir '
unsetopt auto_name_dirs
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
