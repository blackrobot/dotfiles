#!/bin/bash

function say() {
  echo "${1}" | spd-say -p -25 -e
}
