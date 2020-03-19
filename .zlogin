##
# Update stuff in the background
# https://github.com/htr3n/zsh-config/blob/master/zlogin
##

(
  setopt LOCAL_OPTIONS
  autoload -Uz zrecompile

  if (( $+commands[tldr] )); then
    tldr --update > /dev/null 2>&1
  fi

  ##
  # Compile completion dumped files
  # https://htr3n.github.io/2018/07/faster-zsh/#compiling-completion-dumped-files
  ##

  # Compile zcompdump, if modified, to increase startup speed.
  zcompdump="$ZSH_COMPDUMP"

  if [[ -z "$zcompdump" ]]; then
    zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  fi

  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zrecompile -pq "$zcompdump"
  fi

  # recompile zshrc files
  zrecompile -pq "${DOTFILES}/.zshrc"
  zrecompile -pq "${DOTFILES}/.zshenv"

) &!
