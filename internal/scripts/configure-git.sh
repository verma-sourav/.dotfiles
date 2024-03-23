#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(realpath "$SCRIPT_DIR/../..")"
source "$SCRIPT_DIR/helpers.sh"

REDO_GIT_SETUP=${REDO_GIT_SETUP:-"false"}
AUTHOR_TEMPLATE="$REPO_ROOT/git/template.author.gitconfig"
AUTHOR_CUSTOMIZED="$REPO_ROOT/git/author.gitconfig"

if file_exists "$AUTHOR_CUSTOMIZED"; then
    if [[ "$REDO_GIT_SETUP" != "true" ]]; then
        echo "Git author information has been set up previously -- skipping prompts"
        echo "If you want to change your git author information, rerun the script with REDO_GIT_SETUP=true"
        exit
    fi

    echo "Git author information is set, but REDO_GIT_SETUP is true -- continuing to setup"
fi

credential_helper="cache"
if on_macos; then
    credential_helper="osxkeychain"
fi

echo "Please enter the name that you would like to use for Git commits (ex: John Doe)"
name="$(gum input --prompt "Author Name > ")"

echo "Please enter the email that you would like to use for Git commits (ex: johndoe@example.com)"
email="$(gum input --prompt "Commit Email > ")"

cat <<EOF
Configuring Git with the following settings:
    user.name         = $name
    user.email        = $email
    credential.helper = $credential_helper
EOF

sed -e "s/AUTHORNAME/$name/g" \
    -e "s/AUTHOREMAIL/$email/g"\
    -e "s/GIT_CREDENTIAL_HELPER/$credential_helper/g" \
    "$AUTHOR_TEMPLATE" > "$AUTHOR_CUSTOMIZED"

echo "Updated git author information"
