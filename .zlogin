# Add Heroku to the path
export PATH="/usr/local/heroku/bin:$PATH"

# Golang
if [ -d $HOME/.golang ]; then
  export GOPATH=$HOME/.golang
  export PATH=$GOPATH/bin:$PATH
fi

# Add rvm to the path
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
