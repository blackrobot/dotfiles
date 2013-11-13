# Add Heroku to the path
if [[ -d "/usr/local/heroku/bin" ]]; then
  export PATH="/usr/local/heroku/bin:$PATH"
fi

# Golang
if [[ -d "${HOME}/.golang" ]]; then
  export GOPATH="${HOME}/.golang"
  export PATH="${GOPATH}/bin:$PATH"
fi

# Add rvm to the path
if [[ -s "${HOME}/.rvm/scripts/rvm" ]]; then
  source "${HOME}/.rvm/scripts/rvm"
fi
