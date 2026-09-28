# ⚡ XFCE Monochrome Rice

> A super lightweight, minimal, dark monochrome desktop setup built on Arch Linux.

Designed for maximum speed, minimalism, and distraction-free productivity. This configuration pairs XFCE4's rock-solid performance with a sleek, dark grayscale aesthetic featuring Rofi launcher styling, custom Fastfetch configurations, and GTK 2.0 theme integration.

---

## 🎨 Overview

* **OS:** Arch Linux
* **Desktop Environment:** XFCE4
* **Window Manager:** Xfwm4
* **App Launcher:** Rofi (`monochrome.rasi`)
* **Fetch Tool:** Fastfetch
* **GTK Theme:** Backlight / Blacklight base

---

## 🛠️ System Requirements & Dependencies

Install all required packages via `pacman`:

```bash
sudo pacman -S --needed xfce4 xfce4-goodies rofi fastfetch git
```

---

## 🚀 Installation & Configuration

### Option A: Quick One-Liner (Automated Setup)

Run this single command in your terminal to create all directories and place all configuration files into their respective locations automatically:

```bash
cd ~ && git clone https://github.com/lostmyblood/XFCE-Monochrome-Rice.git && \
mkdir -p ~/.config/rofi ~/.config/fastfetch ~/.themes/Backlight && \
[ -d XFCE-Monochrome-Rice/rofi ] && cp -r XFCE-Monochrome-Rice/rofi/* ~/.config/rofi/ || true && \
[ -f XFCE-Monochrome-Rice/monochrome.rasi ] && cp XFCE-Monochrome-Rice/monochrome.rasi ~/.config/rofi/ || true && \
[ -d XFCE-Monochrome-Rice/fastfetch ] && cp -r XFCE-Monochrome-Rice/fastfetch/* ~/.config/fastfetch/ || true && \
[ -d XFCE-Monochrome-Rice/Backlight ] && cp -r XFCE-Monochrome-Rice/Backlight/* ~/.themes/Backlight/ || true
```

---

### Option B: Step-by-Step Manual Installation

If you prefer installing components individually, follow these steps:

#### 1. Clone the Repository
```bash
cd ~
git clone https://github.com/lostmyblood/XFCE-Monochrome-Rice.git
cd XFCE-Monochrome-Rice
```

#### 2. Configure Rofi
Copy the `monochrome.rasi` theme file to your user's Rofi config directory:

```bash
mkdir -p ~/.config/rofi
cp rofi/monochrome.rasi ~/.config/rofi/
```

To run Rofi using this theme:
```bash
rofi -show drun -theme ~/.config/rofi/monochrome.rasi
```

#### 3. Configure Fastfetch
Copy the custom Fastfetch configuration:

```bash
mkdir -p ~/.config/fastfetch
cp -r fastfetch/* ~/.config/fastfetch/
```

Test it in your terminal by running:
```bash
fastfetch
```

#### 4. Install GTK Theme (Backlight)
Copy the theme into your local user themes folder:

```bash
mkdir -p ~/.themes/Backlight
cp -r Backlight/* ~/.themes/Backlight/
```

*(Optional system-wide installation)*:
```bash
sudo mkdir -p /usr/share/themes/Blacklight/
sudo cp -r Backlight/gtk-2.0 /usr/share/themes/Blacklight/
```

---

## ⚙️ Applying System Themes

1. Open **Settings Manager** → **Appearance**.
2. Select **Backlight** under the **Style** tab.
3. Open **Settings Manager** → **Window Manager**.
4. Select **Backlight** for your titlebar appearance.
5. In your terminal or keybindings configuration, map your application launcher shortcut to:
   ```bash
   rofi -show drun -theme ~/.config/rofi/monochrome.rasi
   ```

---

## 📂 Repository Structure

```text
XFCE-Monochrome-Rice/
├── Backlight/
│   └── gtk-2.0/           # GTK 2.0 theme configuration files
├── rofi/
│   └── monochrome.rasi    # Custom Rofi launcher theme
├── fastfetch/
│   └── config.jsonc       # Fastfetch system info layout
└── README.md              # Documentation & setup guide
```

---

## 🤝 Contributing

Feel free to fork this repository, submit PRs, or open issues for suggestions to refine this monochrome setup further.

## 📜 License

Distributed under the **MIT License**. Free to use and modify.