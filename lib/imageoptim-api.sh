#!/usr/bin/env bash

set -e

# BASE_API_URL="https://im2.io/xrxxwpwtdb/full"

readonly input_name="$1"
output_name="$2"

function usage {
  local exit_code
  local msg

  exit_code=${1:-0}
  msg="$(printf "%s [-h|--help] <input file> [<output file>]" "$(basename $0)")"

  if [[ $exit_code != 0 ]] ; then
    echo "$msg" >&2
  else
    echo "$msg"
  fi

  exit $exit_code
}

function out_name {
  # Given input_name="foo.bar.png" this will output "foo.bar.min.png"
  printf "%s.min.%s" "${input_name%.*}" "${input_name##*.}"
}

if [[ -z "$input_name" || "$1" == "-h" || "$1" == "--help" ]] ; then
  usage
fi

if [[ -z "$output_name" ]] ; then
  output_name="$(out_name)"

  if [[ -e "$output_name" ]]; then
    printf 'The output path "%s" already exists. Please specify one instead.\n' \
      "$output_name" >&2
    usage 1
  fi
fi

http --form \
     --download \
     --output "$output_name" \
     "https://im2.io/xrxxwpwtdb/full" file@"$input_name"