# VisualBoyAdvance-M Anylinux AppImages 🐧

## Build status

[![GitHub Downloads](https://img.shields.io/github/downloads/carlos-a-g-h/vbam-anylinux-appimage/total?logo=github&label=GitHub%20Downloads)](https://github.com/carlos-a-g-h/vbam-anylinux-appimage/releases/latest)

[![CI Build Status](https://github.com//carlos-a-g-h/vbam-anylinux-appimage/actions/workflows/appimage.yml/badge.svg)](https://github.com/carlos-a-g-h/vbam-anylinux-appimage/releases/latest)

* [Latest Stable Release](https://github.com/carlos-a-g-h/vbam-anylinux-appimage/releases/latest)

## About this AppImage

VisualBoyAdvance-M does [not provide an AppImage officially on their upstream](https://github.com/visualboyadvance-m/visualboyadvance-m/releases). And that is the reason why I made this repository: To provide not just AppImages, but AppImages that can run ANYWHERE, details about this at the end of this README

<details>
  <summary><b><i>THIS IS REAL</i></b></summary>
    <img width="1920" alt="gottaseethis" src="https://github.com/user-attachments/assets/bb00e59f-78eb-4bf2-9e03-18e20ae19253" />
    <strong><i>System: Debian 11, libc6 2.31</i></strong>
</details>

### Variants/Versions

| Version | Variant name | Status | Description |
|-|-|-|-|
| v2.2.3 | arch1 | BROKEN | Built from source on Arch |
| v2.2.3 | alt1 | WORKING | Built using ALT Linux packages. Released for x64 and ARM |
| v2.1.0 | ubuntu1 | WORKING | Built using Ubuntu packages from a specific PPA |

### Internal scripts and programs

These AppImages have internal scripts and programs, that can be launched by calling them as commandline arguments

```
./VBA-M.AppImage [program]
```

This AppImage has internal scripts and programs that can be launched by calling them as commandline arguments

|Program or script|Description|
|-|-|
|vbam|Run SDL port instead of the wxGTK port|
| setup | An "installation" script for the appimage. It provides a nice config, a DESKTOP file in /usr/share/applications and an icon |
| details | Extracts the "details" directory from the AppImage |

### About the setup script

This script can help you integrate the appimage to your system

```
./VBA-M.AppImage setup [FLAGS]
```

| Flag | Description |
|-|-|
| --install | Performs the installation, integrating the appimage to your system |
| --no-config | Will not copy the recommended config to your system |
| --no-links | Will not create symlinks that go from /usr/bin/ to the AppImage |
| --no-desktop | Will not create the application desktop file and its icon |
| --force | Overwrites in case that there are files or paths that already exist |

Use the command without any arguments for more details

## What is AnyLinux ?

These AppImages are made using [sharun](https://github.com/VHSgunzo/sharun), which makes it extremely easy to turn any binary into a portable package without using containers or similar tricks.

**These AppImages bundle everything and should work on any linux distro, even on musl based ones.**

These AppImages can work **without FUSE** at all thanks to the [uruntime](https://github.com/VHSgunzo/uruntime)

More at: [AnyLinux-AppImages](https://pkgforge-dev.github.io/Anylinux-AppImages/)

<details>
  <summary><b><i>raison d'être</i></b></summary>
    <img src="https://github.com/user-attachments/assets/d40067a6-37d2-4784-927c-2c7f7cc6104b" alt="Inspiration Image">
</details>
