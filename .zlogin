# heroku
if [[ -d "/usr/local/heroku/bin" ]]; then
  export PATH="/usr/local/heroku/bin:$PATH"
fi

# golang
if [[ -d "${HOME}/.golang" ]]; then
  export GOPATH="${HOME}/.golang"
  export PATH="${GOPATH}/bin:$PATH"
fi

# direnv
if (( $+commands[direnv] )); then
  eval "$(direnv hook zsh)"
fi
