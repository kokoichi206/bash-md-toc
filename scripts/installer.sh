#!/bin/bash
#
# Description
#    install md-toc.
#
# Usage:
#    bash scripts/installer.sh
#
set -euo pipefail

BASE_URL=""

function install_cmd() {
    echo "===== installing md-toc command to /usr/local/bin/md-toc ====="
    install -m 0755 -D ./md-toc.sh /usr/local/bin/md-toc
}

function install_man() {
    echo "===== installing md-toc manual to /usr/share/man/man1/md-toc.1.gz ====="
    install -m 0644 -D ./docs/man/md-toc.1.gz /usr/share/man/man1
}

install_cmd
install_man
