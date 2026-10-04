# CDOS

> A work distribution for developers, based on Debian 13 (Trixie).

CDOS is a Linux distribution designed for developers who need a reliable, ready-to-use working environment out of the box. It is built on top of Debian Stable and ships with a curated set of tools for software development, containers, and day-to-day office work.

---

## What is CDOS?

CDOS is a personal take on what a developer-focused Debian derivative should look like. It is not intended to compete with general-purpose distributions, but to offer a *batteries-included* environment for people who spend their day in a terminal, an IDE, and a browser.

The project is in **early alpha**. The current ISO is a Live image with a full KDE Plasma desktop, development tooling, and a custom welcome screen. An installer for permanent disk installation is planned but not yet available.

---

## Key features

- **Base**: Debian 13 (Trixie), Stable branch.
- **Desktop**: KDE Plasma 6 + SDDM (X11 session).
- **Shell**: `fish` inside Konsole, with `bash` kept as the login shell to avoid KDE session issues.
- **Java**: OpenJDK 21 and OpenJDK 25, side by side.
- **Python**: Python 3.13 with `pip`, `venv`, and dev headers.
- **Node.js**: Node 20 (system-wide) plus `fnm` for per-user version management.
- **Go**: Go 1.24.
- **Containers**: Docker CE + buildx + compose plugins.
- **Editors**: VS Code and Neovim.
- **Office**: ONLYOFFICE Desktop Editors, Thunderbird, KMail, FileZilla.
- **Browser**: Firefox ESR (Debian's long-term support Firefox).
- **CLI tools**: `ripgrep`, `fd-find`, `fzf`, `bat`, `eza`, `tig`, `htop`, `iotop`, `tmux`, `jq`, and network diagnostics (`nmap`, `tcpdump`, `iftop`, `dnsutils`, `traceroute`, `whois`).
- **Custom branding**: hostname `cdos`, live user `live`, custom MOTD with ASCII logo, internationalized welcome screen (Spanish, English, French, German).

---

## Project status

| Component             | Status        |
| --------------------- | ------------- |
| Base system           | Stable        |
| KDE Plasma desktop    | Stable        |
| Development tooling   | Stable        |
| Custom welcome screen | Stable        |
| Branding              | Functional    |
| Installer             | Not available |
| Public releases       | Not yet       |

This is an **alpha** project. The Live ISO works, but there is no stable release process, no automatic CI builds, and no long-term support guarantee. Use it at your own risk.

---

## Building from source

### Requirements

- A Debian 13 (Trixie) host system, physical or virtual.
- At least **4 CPU cores**, **8 GB of RAM** and **20 GB of free disk space**.
- An Internet connection for downloading packages during the build.
- `sudo` access on the build host.

### Build steps

```bash
# 1. Install build dependencies
sudo apt update
sudo apt install -y live-build git build-essential debootstrap

# 2. Clone the repository
git clone https://github.com/formatocd/cdos.git
cd cdos

# 3. Configure the build environment
sudo bash auto/config

# 4. Build the ISO
sudo lb build
```

The resulting ISO will be named `live-image-amd64.hybrid.iso` in the current directory. It is a hybrid image: it can be written to a USB stick with `dd` or burned to a DVD.

For a more detailed walkthrough, including how to contribute patches and report bugs, see [`CONTRIBUTING.md`](CONTRIBUTING.md).

---

## Repository structure

```
cdos/
├── auto/                    # Build recipe (lb config parameters)
├── bin/                     # Developer helper scripts
├── config/                  # live-build configuration
│   ├── archives/            # External APT repositories (VSCode, Docker, ONLYOFFICE)
│   ├── hooks/               # Custom hooks run during the build
│   ├── includes.chroot/     # Files copied into the ISO filesystem
│   ├── package-lists/       # Package lists per feature
│   └── ...
└── local/                   # Local-only overrides (not versioned)
```
