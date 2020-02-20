#!/usr/bin/env bash

set -e

LOG_PATH="$(cd "$(dirname "${0}")" && pwd)"
readonly LOG_PATH

log_file="${LOG_PATH}/extensions.log"

printf "Saving extensions to %s\n" "$log_file"

code --list-extensions --show-versions | sort > "$log_file"
