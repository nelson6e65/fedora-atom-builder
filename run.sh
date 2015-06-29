#!/usr/bin/env bash
# -*- ENCODING: UTF-8 -*-

echo "Atom builder for Fedora"

if [[ -z $ROOT_DIR ]]; then
    # Current script directory
    declare -xr ROOT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
fi

. "$ROOT_DIR/config/init"

if [[ $? -ne 0 ]]; then
    echo "Internal Error: Inicialize."
    exit 1
fi

function bash_header() {
    clear
    echo_separator "#"
    echo "# Atom Builder for Fedora"
    echo "# by @nelson6e65         "
    echo_separator "#"
}

bash_header

echo_header "Directories that will be used" "-"
dir=$(font_bold "$ROOT_DIR")
echo "Root working directory: '$dir'"
dir=$(font_bold "$ROOT_DIR")
echo "Sources directory:      '$dir'"

log_cd "$ROOT_DIR"

declare -i errors=$E_NONE

script/install-dependencies
errors=$(( errors | $? ))

script/get-sources
errors=$(( errors | $? ))

pause

exit $errors
