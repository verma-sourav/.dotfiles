#!/usr/bin/env bash
# ----------------------------------------------------------------------------------------------------------------------
# replace-author.sh
# Allow the user to update their git author info using sed
# ----------------------------------------------------------------------------------------------------------------------
set -euo pipefail

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

AUTHOR_TEMPLATE="$BASEDIR/template.author.gitconfig"
AUTHOR_CUSTOMIZED="$BASEDIR/author.gitconfig"

CREDENTIAL_HELPER="cache"
NAME=
EMAIL=

if [[ ! -f "$AUTHOR_CUSTOMIZED" ]]; then
    if [[ "$(uname -s)" == "Darwin" ]]; then
        CREDENTIAL_HELPER="osxkeychain"
    fi

    echo "Setting up git author information"
    read -e -r -p "Please enter the name you would like to use: " NAME
    read -e -r -p "Please enter the email address you would like to use: " EMAIL
    sed -e "s/AUTHORNAME/$NAME/g" \
        -e "s/AUTHOREMAIL/$EMAIL/g"\
        -e "s/GIT_CREDENTIAL_HELPER/$CREDENTIAL_HELPER/g" \
        "$AUTHOR_TEMPLATE" > "$AUTHOR_CUSTOMIZED"
    echo "Updated git author information"
fi
