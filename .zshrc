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

export WORKSPACE="$HOME/Workspace"
dj () {
	cd "$WORKSPACE/django-projects/$1";
	if [ -f "$WORKON_HOME/$1/bin/activate" ]; then
		source "$WORKON_HOME/$1/bin/activate";
	elif [ -e "$WORKSPACE/django-projects/$1/local-env/bin/activate" ]; then
		source "$WORKSPACE/django-projects/$1/local-env/bin/activate";
	fi
}
runsrv () {
	if [ -f "source/manage.py" ]; then
		python source/manage.py runserver $1;
	elif [ -f "manage.py" ]; then
		python manage.py runserver $1;
	fi
}
wrk () { cd "$WORKSPACE/$1" && ls -alh; }

alias man="TERMINFO=~/.terminfo LESS=C TERM=mostlike PAGER=less man"
alias l="ls -alh"
alias lg="l | grep"
alias grepir='grep -Ir'
alias bro='sudo apt-get'
unsetopt auto_name_dirs
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.

export ORACLE_HOME=/usr/lib/oracle/11.2/client64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$ORACLE_HOME/lib:/usr/local/lib
export TNS_ADMIN=$ORACLE_HOME/network/admin
