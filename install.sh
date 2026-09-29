#!/usr/bin/env bash
#
# install-monochrome-rice.sh
# Deploys lostmyblood/XFCE-Monochrome-Rice to the right locations and applies
# the Blacklight GTK + window manager styles.
#
# Usage:  ./install-monochrome-rice.sh [--with-keybinds]
#   Run as your NORMAL user (not root / not with sudo). The script calls sudo
#   itself only for the copy into /usr/share/themes, so that xfconf settings
#   are applied to YOUR session instead of root's.

set -euo pipefail

REPO_URL="https://github.com/lostmyblood/XFCE-Monochrome-Rice.git"
THEME_NAME="Blacklight"   # name declared in index.theme (repo folder is "Backlight")
WITH_KEYBINDS=false
[[ "${1:-}" == "--with-keybinds" ]] && WITH_KEYBINDS=true

info() { printf '\033[1;32m[+]\033[0m %s\n' "$*"; }
warn() { printf '\033[1;33m[!]\033[0m %s\n' "$*"; }
die()  { printf '\033[1;31m[x]\033[0m %s\n' "$*" >&2; exit 1; }

# --- Sanity checks -----------------------------------------------------------
[[ $EUID -eq 0 ]] && die "Don't run as root. Run as your normal user; sudo is used only where needed."
command -v sudo >/dev/null || die "sudo is required to install the theme to /usr/share/themes."

# --- Locate the repo (use the local copy if the script sits inside it) -------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CLEANUP=""
if [[ -d "$SCRIPT_DIR/Backlight" && -d "$SCRIPT_DIR/rofi" ]]; then
    REPO="$SCRIPT_DIR"
    info "Using local repo at $REPO"
else
    command -v git >/dev/null || die "git is required (sudo pacman -S git)."
    REPO="$(mktemp -d)/XFCE-Monochrome-Rice"
    CLEANUP="$(dirname "$REPO")"
    info "Cloning repo to $REPO"
    git clone --depth 1 "$REPO_URL" "$REPO"
fi
trap '[[ -n "$CLEANUP" ]] && rm -rf "$CLEANUP"' EXIT

# --- Helper: copy with backup of anything we'd overwrite ---------------------
BACKUP_DIR="$HOME/.config/monochrome-rice-backup-$(date +%Y%m%d-%H%M%S)"
backup_if_exists() {
    local target="$1"
    if [[ -e "$target" ]]; then
        mkdir -p "$BACKUP_DIR"
        cp -a "$target" "$BACKUP_DIR/$(echo "$target" | tr '/' '_')"
    fi
}

# --- 1. Rofi: monochrome.rasi -> ~/.config/rofi ------------------------------
info "Installing Rofi theme"
mkdir -p "$HOME/.config/rofi"
backup_if_exists "$HOME/.config/rofi/monochrome.rasi"
cp -f "$REPO/rofi/monochrome.rasi" "$HOME/.config/rofi/"

# --- 2. Fastfetch: config.jsonc -> ~/.config/fastfetch -----------------------
info "Installing Fastfetch config"
mkdir -p "$HOME/.config/fastfetch"
backup_if_exists "$HOME/.config/fastfetch/config.jsonc"
cp -f "$REPO/fastfetch/config.jsonc" "$HOME/.config/fastfetch/"

# --- 3. GTK / xfwm4 theme -> /usr/share/themes/Blacklight --------------------
info "Installing $THEME_NAME theme to /usr/share/themes (sudo required)"
sudo mkdir -p "/usr/share/themes/$THEME_NAME"
sudo cp -rf "$REPO/Backlight/." "/usr/share/themes/$THEME_NAME/"

# --- 4. Panel files -> ~/.config/xfce4/panel ---------------------------------
info "Installing panel files"
mkdir -p "$HOME/.config/xfce4/panel"
backup_if_exists "$HOME/.config/xfce4/panel/wavelan-1.rc"
backup_if_exists "$HOME/.config/xfce4/panel/spotify-now-playing.sh"
cp -rf "$REPO/xfce4/panel/." "$HOME/.config/xfce4/panel/"
chmod +x "$HOME/.config/xfce4/panel/spotify-now-playing.sh"

# --- 5. Optional: keybindings ------------------------------------------------
if $WITH_KEYBINDS; then
    info "Installing XFCE keybindings"
    XFCONF_DIR="$HOME/.config/xfce4/xfconf/xfce-perchannel-xml"
    mkdir -p "$XFCONF_DIR"
    backup_if_exists "$XFCONF_DIR/xfce4-keyboard-shortcuts.xml"
    cp -f "$REPO/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml" "$XFCONF_DIR/"
fi

# --- 6. Apply GTK style + window manager style -------------------------------
info "Applying $THEME_NAME GTK and window manager styles"
if command -v xfconf-query >/dev/null && [[ -n "${DBUS_SESSION_BUS_ADDRESS:-}" ]]; then
    xfconf-query -c xsettings -p /Net/ThemeName -n -t string -s "$THEME_NAME" \
        || xfconf-query -c xsettings -p /Net/ThemeName -s "$THEME_NAME"
    xfconf-query -c xfwm4 -p /general/theme -n -t string -s "$THEME_NAME" \
        || xfconf-query -c xfwm4 -p /general/theme -s "$THEME_NAME"
    xfwm4 --replace >/dev/null 2>&1 & disown || true
else
    warn "No running XFCE session detected. Apply manually:"
    warn "  Settings > Appearance > Style > $THEME_NAME"
    warn "  Settings > Window Manager > Style > $THEME_NAME"
fi

# --- Done --------------------------------------------------------------------
info "Done."
[[ -d "$BACKUP_DIR" ]] && info "Previous files were backed up to $BACKUP_DIR"
command -v playerctl >/dev/null || warn "playerctl not found; spotify-now-playing.sh needs it (sudo pacman -S playerctl)."
warn "wavelan-1.rc is set to interface 'wlo1'. Check yours with: ip link"
