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

# pause

script/get-sources
errors=$(( errors | $? ))

if [[ $errors -eq 0 ]]; then
    echo_separator '_'
    echo_separator '='
    echo_header "Building Atom"
    echo_separator '='; echo

    log_cd "$SRC_DIR/atom"

    echo_header "Building" "-"
    script/build

    echo_result

    echo_separator '_'
else
    echo "Dependencies and sources needed in order to build"
fi


if [[ $errors -eq 0 ]]; then
    echo_separator '_'
    echo_separator '='
    echo_header "Generating .RPM installer"
    echo_separator '='; echo

    log_cd "$SRC_DIR/atom"

    script/grunt mkrpm

    echo_result

    echo_separator '_'
else
    echo "Build sources is needed"
fi


echo "Complete result:"
echo_result

exit $errors
