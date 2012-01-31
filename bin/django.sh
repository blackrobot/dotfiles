# This makes a shortcut for typing "dj <project-name>" to put you in that
# directory and then activate the virtual environment if it can be found. If
# left blank, it will drop you in your django-projects directory.

export WORKSPACE="$HOME/Workspace"
export _DJANGO="${WORKSPACE}/django-projects"

dj () {
  local LS_ARGS="-alh --color"

  cd "${_DJANGO}/$1";

  if [ -f "$WORKON_HOME/$1/bin/activate" ]; then
    source "${WORKON_HOME}/${1}/bin/activate"

  elif [ -e "${_DJANGO}/${1}/local-env/bin/activate" ]; then
    source "${_DJANGO}/${1}/local-env/bin/activate"

  else
    ls $LS_ARGS

  fi
}

wrk () {
  cd "${WORKSPACE}/${1}" && ls $LS_ARGS
}
