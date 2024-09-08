#!/bin/bash

set -euo pipefail; UNDEFINED_VARS=()

err() { echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2; exit 1; }
check_var() { set +u; if [ -z "${!1}" ]; then UNDEFINED_VARS+=("$1"); fi; }
finish_check_vars(){ if [[ ${#UNDEFINED_VARS[@]} -gt 0 ]]; then err "The following variables are undefined: ${UNDEFINED_VARS[*]}"; fi }

check_var var1
check_var var2
finish_check_vars