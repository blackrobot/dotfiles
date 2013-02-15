# Shortcut to creating utf-8 mysql databases
function __mysql_create() {
  local user="root"
  local pass="root"
  local host="localhost"
  local query="CREATE DATABASE ${1} CHARACTER SET utf8 COLLATE utf8_general_ci;"

  mysql -u$user -p$pass -h$host -e "${query}" && \
    echo "Created new database $(tput bold)$(tput setaf 2)${1}$(tput sgr0)"
}

alias mysql-create="__mysql_create"