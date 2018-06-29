DOTFILES="${HOME}/.dotfiles"
EDITOR=vim
PAGER=less

# Prevent tar from adding ._* files
COPYFILE_DISABLE=1


function add_to_path {
  # Adds $1 to $PATH if not already there. Add 'after'
  # as an arg to append, the default is to prepend.
  if [[ ":${PATH}:" != *":${1}:"* ]]; then
    if [[ "$2" == "append" ]]; then
      PATH="${PATH}:${1}"
    else
      PATH="${1}:${PATH}"
    fi
  fi
}

# ripgrep config
export RIPGREP_CONFIG_PATH="${DOTFILES}/.ripgreprc"

# nvm
# NVM_LAZY_LOAD=true
NVM_DIR="${HOME}/.nvm"

add_to_path "/usr/local/opt/python/libexec/bin"
add_to_path "/usr/local/sbin"
add_to_path "/usr/local/opt/coreutils/libexec/gnubin"
add_to_path "${HOME}/.yarn/bin"
# add_to_path "~/.config/yarn/global/node_modules/.bin" 'append'

# pyenv
PYENV_ROOT="${HOME}/.pyenv"
PATH="${PYENV_ROOT}/bin:${PATH}"
# eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init -)"

# rust
add_to_path "${HOME}/.cargo/bin"

# android
ANDROID_HOME="${HOME}/Library/Android/sdk"
add_to_path "${ANDROID_HOME}/tools" 'append'
add_to_path "${ANDROID_HOME}/platform-tools" 'append'

# first in $PATH
add_to_path "${DOTFILES}/bin"

# For vs-code
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"