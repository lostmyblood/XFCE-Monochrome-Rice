# XFCE Monochrome Rice

A lightweight, dark monochrome desktop environment configuration for XFCE4 on Arch Linux.
![image](https://raw.githubusercontent.com/lostmyblood/XFCE-Monochrome-Rice/refs/heads/main/screenshots/Screenshot_2026-09-28_19-42-03.png)

## Overview

- **Operating System:** Arch Linux
- **Desktop Environment:** XFCE4
- **Window Manager:** Xfwm4
- **Application Launcher:** Rofi (`monochrome.rasi`)
- **System Information Tool:** Fastfetch
- **Panel Extras:** Spotify now-playing script, Wavelan plugin config
- **GTK Theme:** Blacklight (`/usr/share/themes/Blacklight/`)

> **Note:** The theme folder in this repository is named `Backlight`, but the theme declares itself as `Blacklight` in `index.theme`. It must be installed as `/usr/share/themes/Blacklight/` for XFCE to find it. The install script handles this for you.

## System Dependencies

Install required system packages via `pacman`:

```bash
sudo pacman -S rofi fastfetch git playerctl
```

`playerctl` is only needed for the Spotify now-playing panel script.

## Installation & Configuration

### Automated Setup

```bash
git clone https://github.com/lostmyblood/XFCE-Monochrome-Rice
cd XFCE-Monochrome-Rice/
chmod +x install.sh
./install.sh
```

Run the script as your **normal user**, not with `sudo`. It calls `sudo` itself only for the copy into `/usr/share/themes`, so the style settings are applied to your session rather than root's.

To also install the custom XFCE keybindings, run:

```bash
./install.sh --with-keybinds
```

The script will:

1. Copy `rofi/monochrome.rasi` to `~/.config/rofi/` (creating the directory if needed).
2. Copy `fastfetch/config.jsonc` to `~/.config/fastfetch/` (creating the directory if needed).
3. Install the `Backlight` folder to `/usr/share/themes/Blacklight/`.
4. Copy everything in `xfce4/panel/` to `~/.config/xfce4/panel/`.
5. Apply **Blacklight** as the GTK style and the window manager style, then restart `xfwm4`.
6. Back up any file it would overwrite to `~/.config/monochrome-rice-backup-<timestamp>/`.

If no running XFCE session is detected (for example over SSH), the script skips step 5 and prints the settings to change by hand. See [System Configuration](#system-configuration).

### Manual Setup

#### 1. Repository Retrieval

```bash
cd ~
git clone https://github.com/lostmyblood/XFCE-Monochrome-Rice.git
cd XFCE-Monochrome-Rice
```

#### 2. Rofi Configuration

```bash
mkdir -p ~/.config/rofi
cp -r rofi/* ~/.config/rofi/
```
![image](https://raw.githubusercontent.com/lostmyblood/XFCE-Monochrome-Rice/refs/heads/main/screenshots/rofi.jpg)

#### 3. Fastfetch Configuration

```bash
mkdir -p ~/.config/fastfetch
cp -r fastfetch/* ~/.config/fastfetch/
```
![image](https://raw.githubusercontent.com/lostmyblood/XFCE-Monochrome-Rice/refs/heads/main/screenshots/fastfetch.png)

#### 4. System GTK Theme Setup

Deploy all contents of the `Backlight` folder into `/usr/share/themes/Blacklight/`:

```bash
sudo mkdir -p /usr/share/themes/Blacklight
sudo cp -r Backlight/* /usr/share/themes/Blacklight/
```
![image](https://raw.githubusercontent.com/lostmyblood/XFCE-Monochrome-Rice/refs/heads/main/screenshots/globalstyle.png)
![image](https://raw.githubusercontent.com/lostmyblood/XFCE-Monochrome-Rice/refs/heads/main/screenshots/windowmanager.png)

#### 5. Panel Files

Copy the panel scripts, icons and plugin configs:

```bash
mkdir -p ~/.config/xfce4/panel
cp -r xfce4/panel/* ~/.config/xfce4/panel/
chmod +x ~/.config/xfce4/panel/spotify-now-playing.sh
```

- `spotify-now-playing.sh` shows the current Spotify track via `playerctl`. Add it to the panel with a **Generic Monitor** plugin pointing at the script.
- `wavelan-1.rc` is configured for the network interface `wlo1`. Edit the `Interface=` line to match yours (run `ip link` to list interfaces).

#### 6. XFCE Keybinds

Replace the existing XFCE keyboard shortcuts configuration file with the repository's custom keybindings file:

```bash
mkdir -p ~/.config/xfce4/xfconf/xfce-perchannel-xml/
cp xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
```

## System Configuration

The automated script applies these settings for you. For a manual install, either use the GUI:

1. Navigate to **Settings Manager** -> **Appearance**.
2. Under the **Style** tab, select **Blacklight**.
3. Navigate to **Settings Manager** -> **Window Manager**.
4. Select **Blacklight** for titlebar frame styling.

or apply them from the terminal:

```bash
xfconf-query -c xsettings -p /Net/ThemeName -s "Blacklight"
xfconf-query -c xfwm4 -p /general/theme -s "Blacklight"
```

If a keybinding or theme change doesn't show up, log out and back in.
