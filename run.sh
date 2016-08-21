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
    declare title="Fedora Atom Builder"
    declare description="Bash helper to compile Atom Editor (http://atom.io)."
    declare copyright="2015-2016 (c) Nelson Martell (@nelson6e65)"
    declare page="http://nelson6e65.github.io/fedora-atom-builder"

    clear

    alert_debug "${description}\n${copyright}" "${title}"

    echo_separator "#"

    echo "# ${title}"
    echo "# ${description}"
    echo "# ${copyright}"
    echo "# Web: ${page}"

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

declare msg=""
if [[ $errors -eq 0 ]]; then
    msg="\nYou can install your Atom Editor by runing:"
    msg+="\n  sudo dnf install ${ROOT_DIR}/dist/atom-*.rpm"
    msg+="\nor find 'atom-*.rpm' file in '${ROOT_DIR}/dist' directory."
    show_success "${msg}" "Fedora Atom Builder finished"
    echo "Available:"
    ls -l "${ROOT_DIR}/dist"
else
    msg="Some errors occurrs while runing tasks!"
    show_error "${msg}" "Fedora Atom Builder failed!"
fi

pause

exit $errors
