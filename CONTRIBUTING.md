# Contributing to CDOS

Thank you for your interest in CDOS. This document explains how to
report bugs, propose changes, and build the ISO locally.

CDOS is an early-alpha project maintained primarily by one person.
Feedback, bug reports, and pull requests are welcome, but please be
patient: responses may take a few days.

---

## Reporting bugs

Before opening a new issue, please:

1. **Search existing issues** to avoid duplicates:
   https://github.com/formatocd/cdos/issues

2. **Check the README** for known limitations and project status:
   https://github.com/formatocd/cdos#project-status

When opening an issue, include:

- **CDOS version**: run `hostnamectl | grep "Operating System"` or
  check the welcome screen.
- **Environment**: physical machine or VM? Which hypervisor? RAM,
  CPU, GPU if relevant.
- **Steps to reproduce**: what you did, what you expected, what
  actually happened.
- **Logs or screenshots** if applicable.

Please do not report security issues in public. Send an email
instead (see the repository profile for contact information).

---

## Proposing changes

CDOS follows a **branch + pull request** workflow. Direct pushes to
`main` are reserved for version bumps and trivial documentation
fixes.

### Workflow

1. **Fork** the repository (or create a branch if you have write
   access).

2. **Create a feature branch** from `main`:

   ```bash
   git checkout -b feature/short-description
   ```

3. **Make your changes**. Keep commits small and focused.

4. **Test your changes** by building the ISO and running it in a VM
   (see "Building the ISO" below).

5. **Push the branch** and open a Pull Request against `main`.

6. **Wait for review**. The maintainer may ask for adjustments.

7. **Merge** once approved. The source branch is deleted after the
   merge.

### Commit message convention

CDOS follows [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <short description>

<optional longer description>

<optional footer>
```

Common types:

- `feat`: a new feature
- `fix`: a bug fix
- `chore`: maintenance (version bumps, tooling)
- `docs`: documentation only
- `refactor`: code change that is not a feature or fix
- `test`: adding or fixing tests

Examples from the project history:

```
feat(welcome): add Launch at start toggle in footer
fix(welcome): correct X-KDE-autostart-condition argument order
chore: bump version to 0.5.3
```

---

## Building the ISO

### Requirements

- A Debian 13 (Trixie) host, physical or virtual.
- At least 4 CPU cores, 8 GB of RAM and 20 GB of free disk space.
- Internet connection during the build.
- `sudo` access.

### Steps

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

The resulting ISO will be `live-image-amd64.hybrid.iso` in the
current directory. It is a hybrid image: it can be written to a USB
stick with `dd` or burned to a DVD.

For subsequent builds, `sudo lb build` alone is enough as long as
`config/` and `auto/config` have not changed.

### Testing in a VM

Create a VM with:

- 4 GB of RAM (KDE + Docker will be tight with less).
- 4 vCPU.
- 25 GB of disk.
- VirtualBox, VMware, or QEMU/KVM.

Boot the ISO and verify the change you made.

---

## Repository structure

```
cdos/
├── auto/                    # Build recipe (lb config parameters)
├── bin/                     # Developer helper scripts (not in ISO)
├── config/                  # live-build configuration
│   ├── archives/            # External APT repositories
│   ├── hooks/               # Hooks run during the build
│   ├── includes.chroot/     # Files copied into the ISO filesystem
│   ├── package-lists/       # Package lists, one per feature
│   └── ...
└── local/                   # Local-only overrides (not versioned)
```

### Key directories

- `config/includes.chroot/` mirrors the root filesystem of the ISO.
  A file at `config/includes.chroot/etc/foo.conf` will end up as
  `/etc/foo.conf` in the final system.

- `config/package-lists/` contains one `.list.chroot` file per
  feature area (desktop, development tools, welcome screen). Adding
  a package means editing the corresponding list.

- `config/archives/` declares external APT repositories (VSCode,
  Docker, ONLYOFFICE) along with their GPG keys.

- `config/hooks/normal/` contains scripts run during the build.
  They are named with a numeric prefix to control execution order.

---

## Project conventions

- **Language**: the codebase and documentation are in English.
- **Commits**: Conventional Commits (see above).
- **Branches**: `feature/<name>`, `fix/<name>`, `chore/<name>`.
- **Tags**: `vX.Y.Z-<milestone>`, one per merged PR.
- **Version bumps**: `os-release`, the MOTD, and the welcome screen
  are updated together when a version is tagged.

---

## License

By contributing to CDOS, you agree that your contributions will be
licensed under the GNU General Public License v3.0. See
[`LICENSE`](LICENSE) for the full text.
