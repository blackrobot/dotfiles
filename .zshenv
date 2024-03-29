export DOTFILES="${HOME}/dotfiles"
export EDITOR=nvim
export PAGER=less

# Prevent tar from adding ._* files
export COPYFILE_DISABLE=1


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

add_to_path "${HOMEBREW_PREFIX}/opt/python/libexec/bin"
add_to_path "${HOMEBREW_PREFIX}/sbin"
add_to_path "${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin"
# add_to_path "~/.config/yarn/global/node_modules/.bin" 'append'

# pyenv
PYENV_ROOT="${HOME}/.pyenv"
PATH="${PYENV_ROOT}/bin:${PATH}"

# Python Poetry
add_to_path "${HOME}/.poetry/bin"

# rust
add_to_path "${HOME}/.cargo/bin"

# first in $PATH
add_to_path "${DOTFILES}/bin"

# For vs-code
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Python startup
export PYTHONSTARTUP="${DOTFILES}/python_startup.py"
export VIRTUAL_ENV_DISABLE_PROMPT=1

