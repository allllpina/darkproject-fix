# Dark Project Web Lab (Offline PWA Launcher)
> [!NOTE]
> **NOTE:** Not all features are still working perfectly due to problems with parsing asset files and by lazyness, if you know how to fix a certain problem - I'd be glad to see your PR :D

[![Linux](https://img.shields.io/badge/platform-Linux-FCC624?style=flat-square&logo=linux&logoColor=black)](https://kernel.org)
[![Bash](https://img.shields.io/badge/shell-Bash-4EAA25?style=flat-square&logo=gnu-bash&logoColor=white)](https://www.gnu.org/software/bash/)
[![Python](https://img.shields.io/badge/runtime-Python_3-3776AB?style=flat-square&logo=python&logoColor=white)](https://www.python.org/)
[![Chrome](https://img.shields.io/badge/browser-Chromium-4285F4?style=flat-square&logo=google-chrome&logoColor=white)](https://www.google.com/chrome/)

Standalone desktop integration and local runner for the Dark Project keyboard web configuration software (`software.darkproject.eu`).

The official web app had some trouble detecting my keyboard (ALU87A), which caused me a lot of trouble setting up the color scheme (I simply couldn't do it). My saga with DP support lasted three months, and they finally sent me a QuickFix for their web software, so I decided to create a permanent offline version that would perform all the functions I need. I have no objection to making this code publicly available, since I found it in the public domain; therefore, as long as there are no objections from the code’s owners, it will remain on my GitHub, open to collaboration on improvements.

---

## Prerequisites

- **Linux** (tested on X11 & Wayland)
- **Bash** (v4.0+)
- **Python 3** (used strictly for the standard library `http.server`)
- Any Chromium-based browser providing `--app` mode support:
  - `google-chrome-stable` (default in `run.sh`) or `chromium`
- `desktop-file-utils` / `update-desktop-database` (standard in almost all distributions)

---

## Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/allllpina/darkproject-fix
    cd darkproject-fix
    ```

2. Run the automated installer:
    ``` bash
    chmod +x install.sh
    ./install.sh
    ```

The script will:

- Determine the absolute workspace path dynamically.

- Mark run.sh as executable.

- Register an XDG Desktop Entry at `~/.local/share/applications/dark-project-lab.desktop.`

- Rebuild the desktop MIME and launcher cache (making it instantly searchable in Rofi, Wofi, Walker, KDE KRunner, and GNOME Shell).

## Architecture & How It Works
Launching via `run.sh` handles process lifecycle isolation cleanly:

1. **Local Static Server**: Starts `python -m http.server 8042` serving strictly the mirrored asset bundle root.

2. Process Sandboxing: Launches the browser with:

    - `--app=http://localhost:8042/index.html` (minimal standalone window frame).

    - `--user-data-dir=/tmp/dp_web_lab_profile` (forces a discrete browser instance so it does not attach to your main browser process via IPC and exit prematurely).

    - `--class="dark-project-lab"` (ensures proper taskbar grouping and window management).

**Graceful Teardown:** Uses a Bash `trap ... EXIT` signal handler to terminate the background Python HTTP daemon immediately when the window is closed or on `SIGINT`/`SIGTERM`.

## Uninstallation
To purge the .desktop file and temporary profiles:

```Bash
chmod +x uninstall.sh
./uninstall.sh
```
