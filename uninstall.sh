#!/bin/bash
set -euo pipefail

#
# This uninstall does NOT remove system packages. It only removes the hooks, aliases and scripts implemented by fix-opera's 'install.sh'.
#

INSTALL_PATH="/root/.scripts"

# --- privilege check ---
if [[ "$(id -u)" -ne 0 ]]; then
    echo "Please run this script with sudo or as root"
    exit 1
fi

# --- user resolution ---
USER_NAME="${SUDO_USER:-$(logname)}"
USER_HOME=$(getent passwd "$USER_NAME" | cut -d: -f6)

# --- package manager detection ---
detect_pkg_manager() {
    if command -v apt-get >/dev/null 2>&1; then
        PKG_MGR="apt"
    elif command -v dnf >/dev/null 2>&1; then
        PKG_MGR="dnf"
    elif command -v pacman >/dev/null 2>&1; then
        PKG_MGR="pacman"
    else
        PKG_MGR="unknown"
    fi
}

remove_hook() {
    case "$PKG_MGR" in
        apt)
            rm -f /etc/apt/apt.conf.d/99fix-opera
            ;;
        pacman)
            rm -f /usr/share/libalpm/hooks/fix-opera.hook
            ;;
        dnf)
            rm -f /etc/dnf/plugins/post-transaction-actions.d/fix-opera.action
            ;;
        *)
            echo "No supported package manager hook to remove"
            ;;
    esac
}

detect_pkg_manager
remove_hook

# --- remove alias ---
if [[ -f "$USER_HOME/.bashrc" ]]; then
    sed -i '/alias fix-opera=.*Opera fix HTML5 media/d' "$USER_HOME/.bashrc"
fi

# --- remove installed files ---
rm -rf "$INSTALL_PATH"

echo "Opera Widevine fix has been removed."
