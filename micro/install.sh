#!/usr/bin/env bash
# ----------------------------------------------------------------------------------------------------------------------
# install.sh
# This install script installs the micro text editor https://github.com/zyedidia/micro
# ----------------------------------------------------------------------------------------------------------------------

set -e
cd "$(dirname "$0")"
source ../scripts/common/checks.sh
source ../scripts/common/logging.sh

if ! cmd_exists micro; then
    log_warn "Micro is already installed."
    exit 0
fi

log_info "Installing micro..."
curl -fsSL https://getmic.ro | bash &> /dev/null
log_info "Moving micro to /usr/bin..."
log_warn "This may require you to enter your password."
sudo mv micro /usr/bin
log_success "Successfully installed micro!"
