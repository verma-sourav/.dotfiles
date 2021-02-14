#!/usr/bin/env bash
# ----------------------------------------------------------------------------------------------------------------------
# replace-author.sh
# Allow the user to update their git author info using sed
# ----------------------------------------------------------------------------------------------------------------------
CREDENTIAL_HELPER="cache"
NAME=
EMAIL=

set -e

echo "Setting up git author information"

if [[ -f git/gitconfig ]]; then
        echo "A customized gitconfig has already been created"
        exit
fi

if [[ "$(uname -s)" == "Darwin" ]]; then
    CREDENTIAL_HELPER="osxkeychain"
fi

read -e -r -p "Please enter the name you would like to use: " NAME
read -e -r -p "Please enter the email address you would like to use: " EMAIL

sed -e "s/AUTHORNAME/$NAME/g" -e "s/AUTHOREMAIL/$EMAIL/g" -e "s/GIT_CREDENTIAL_HELPER/$CREDENTIAL_HELPER/g" git/template-gitconfig > git/gitconfig
echo "Updated git author information"
