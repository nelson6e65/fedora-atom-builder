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

if [[ $errors -eq 0 ]]; then
    script/get-sources
    errors=$(( errors | $? ))
else
    echo "Some dependecies are needed!"
fi
# pause


if [[ $errors -eq 0 ]]; then
    script/build-sources
    errors=$(( errors | $? ))
else
    echo "Sources is needed"
fi


if [[ $errors -eq 0 ]]; then
    script/build-rpm
    errors=$(( errors | $? ))
else
    echo "Build sources is needed"
fi

echo "Total:"
echo_result $errors

if [[ $errors -eq 0 ]]; then
    echo "Done!"
    echo "Now you can install your Atom Editor by runing:"
    echo "  sudo dnf install ${ROOT_DIR}/dist/atom-*.rpm"
    echo "or explore 'atom-*.rpm' file in '${ROOT_DIR}/dist':"
    ls "${ROOT_DIR}/dist"
fi

pause

exit $errors
