# XFCE Monochrome Rice

A lightweight, dark monochrome desktop environment configuration for XFCE4 on Arch Linux.
![image](https://raw.githubusercontent.com/lostmyblood/XFCE-Monochrome-Rice/refs/heads/main/screenshots/Screenshot_2026-09-28_19-42-03.png)

## Overview

- **Operating System:** Arch Linux
- **Desktop Environment:** XFCE4
- **Window Manager:** Xfwm4
- **Application Launcher:** Rofi (`monochrome.rasi`)
- **System Information Tool:** Fastfetch
- **GTK Theme:** Blacklight (`/usr/share/themes/Blacklight/`)

## System Dependencies

Install required system packages via `pacman`:

```bash
sudo pacman -S rofi fastfetch git
```

## Installation & Configuration

### Automated Setup

Run the following command sequence to clone the repository and deploy configurations to their target paths:

```bash
cd ~ && git clone [https://github.com/lostmyblood/XFCE-Monochrome-Rice.git](https://github.com/lostmyblood/XFCE-Monochrome-Rice.git) && \
mkdir -p ~/.config/rofi ~/.config/fastfetch ~/.config/xfce4/xfconf/xfce-perchannel-xml && \
sudo mkdir -p /usr/share/themes/Blacklight && \
[ -d XFCE-Monochrome-Rice/rofi ] && cp -r XFCE-Monochrome-Rice/rofi/* ~/.config/rofi/ || true && \
[ -f XFCE-Monochrome-Rice/monochrome.rasi ] && cp XFCE-Monochrome-Rice/monochrome.rasi ~/.config/rofi/ || true && \
[ -d XFCE-Monochrome-Rice/fastfetch ] && cp -r XFCE-Monochrome-Rice/fastfetch/* ~/.config/fastfetch/ || true && \
[ -f XFCE-Monochrome-Rice/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml ] && cp XFCE-Monochrome-Rice/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml || true && \
[ -d XFCE-Monochrome-Rice/Backlight ] && sudo cp -r XFCE-Monochrome-Rice/Backlight/* /usr/share/themes/Blacklight/ || true```
```

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
4. XFCE Keybinds

Replace the existing XFCE keyboard shortcuts configuration file with the repository's custom keybindings file:
```
mkdir -p ~/.config/xfce4/xfconf/xfce-perchannel-xml/
cp xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-keyboard-shortcuts.xml
```

## System Configuration

1. Navigate to **Settings Manager** -> **Appearance**.
2. Under the **Style** tab, select **Blacklight**.
3. Navigate to **Settings Manager** -> **Window Manager**.
4. Select **Blacklight** for titlebar frame styling.

