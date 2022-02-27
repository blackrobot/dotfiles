#!/usr/bin/env zsh
# shellcheck shell=bash

set -e


PYTHON_VERSION_NAME="$1"
PROG_NAME="$(basename "$0")"


function show_help {
  echo "Usage:"
  echo
  echo "  ${PROG_NAME} [-h|--help] <python-version>"
  echo
  echo "  Use 'pyenv install -ls' to find a python version to install"
  echo "  Example:"
  echo "    ${PROG_NAME} 3.8.0"
}


if [[ "$PYTHON_VERSION_NAME" == '-h' || "$PYTHON_VERSION_NAME" == '--help' ]]; then
  show_help ; exit 0
elif [[ -z "$PYTHON_VERSION_NAME" ]]; then
  show_help ; exit 1
fi


export CFLAGS
export LDFLAGS
export PYTHON_CONFIGURE_OPTS

CFLAGS="-I$(brew --prefix openssl)/include"
LDFLAGS="-L$(brew --prefix openssl)/lib"
PYTHON_CONFIGURE_OPTS="--enable-shared --enable-optimizations --with-computed-gotos"

echo "CFLAGS                = $CFLAGS"
echo "LDFLAGS               = $LDFLAGS"
echo "PYTHON_CONFIGURE_OPTS = $PYTHON_CONFIGURE_OPTS"
echo
echo "${HOMEBREW_PREFIX}/bin/pyenv install --force --verbose $1"
echo

${HOMEBREW_PREFIX}/bin/pyenv install --force --verbose "$1"

# Install default packages
echo
echo "Upgrading pip and installing default packages:"
echo
(
  set -x;
  ${HOMEBREW_PREFIX}/bin/pyenv shell "$1" && \
  pip install --upgrade pip && \
  pip install --upgrade black \
                        flake8 \
                        httpx \
                        ipython \
                        isort \
                        jupyter \
                        ptpython \
                        rope
)
