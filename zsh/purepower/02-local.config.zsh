# Local purepower config
#
# - Powerlevel10k: https://github.com/romkatv/powerlevel10k
# - Purepower: https://github.com/romkatv/dotfiles-public/blob/master/.purepower
# - Config options: https://github.com/bhilburn/powerlevel9k#prompt-customization
# - Font icons: https://nerdfonts.com/#cheat-sheet

() {
  emulate -L zsh && setopt no_unset pipe_fail

  function _pp_c() { print -nr -- $2 }
  function _pp_s() { print -nr -- $2 }

  typeset -g POWERLEVEL9K_MODE='nerdfont-complete'

  typeset -ga POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    dir  # current directory
    vcs  # git status
  )

  typeset -ga POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    status                  # exit code of the last command
    command_execution_time  # duration of the last command
    background_jobs         # presence of background jobs
    virtualenv              # python virtual environment (https://docs.python.org/3/library/venv.html)
    # pyenv                 # python environment (https://github.com/pyenv/pyenv)

    ##
    # Define a function called `custom_rprompt` to dynamically write to the $RPROMPT:
    #   function custom_rprompt() { printf ''; }
    ##
    custom_rprompt          # the output of function `custom_rprompt()` if it is defined

    context                 # user@host
  )

  typeset -g POWERLEVEL9K_SHOW_RULER=false

  local ins='❯'
  local cmd='❮'
  local p="\${\${\${KEYMAP:-0}:#vicmd}:+${${ins//\\/\\\\}//\}/\\\}}}"
  p+="\${\${\$((!\${#\${KEYMAP:-0}:#vicmd})):#0}:+${${cmd//\\/\\\\}//\}/\\\}}}"

  typeset -g POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{%(?.$(_pp_c 2 13).$(_pp_c 1 198))}$p%f "

  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=1

  # Use muted gray for git stash count
  typeset -g POWERLEVEL9K_VCS_{CLEAN,UNTRACKED,MODIFIED}_STASHFORMAT_FOREGROUND=$(_pp_c 8 240)

  unfunction _pp_c _pp_s
} "$@"
