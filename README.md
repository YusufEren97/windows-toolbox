<div align="center">

# Toolbox

<img src="image/toolbox.png" alt="Toolbox" width="600"/>

### Lightweight Windows Utility Toolkit

[![Version](https://img.shields.io/badge/Version-1.0-blue.svg)](https://github.com/YusufEren97/windows-toolbox)
[![License](https://img.shields.io/badge/License-Open_Source-green.svg)](https://github.com/YusufEren97/windows-toolbox)
[![PowerShell](https://img.shields.io/badge/PowerShell-5.1+-purple.svg)](https://docs.microsoft.com/powershell/)
[![Windows](https://img.shields.io/badge/Windows-10%2F11-0078D6.svg?logo=windows)](https://www.microsoft.com/windows)

**Run powerful utilities directly from PowerShell — no installation required.**

[English](#modules) • [Türkçe](#modüller)

</div>

---

## Quick Start

```powershell
irm yusuferenseyrek.com.tr/toolbox | iex
```

> Requires **Administrator privileges** for full functionality.

---

## Modules

<div align="center">

### Port Killer v1.0

Manage and terminate processes occupying network ports.

| Feature | Description |
|---------|-------------|
| Kill Port | Terminate the process bound to a specific port |
| Query Port | View PID and process name for a given port |
| List All Ports | Display all listening ports with PID details |
| Safety Protection | Critical system ports (53, 135, 139, 445, 3389) are protected |

<img src="image/portkiller.png" alt="Port Killer" width="500">

</div>

---

<div align="center">

### System Cleaner v1.1

Free up disk space and flush caches with three cleaning modes.

| Mode | Targets |
|------|---------|
| Quick | User Temp, Windows Temp, Prefetch, Recycle Bin, DNS Cache |
| Deep | All of the above + Windows Error Reports + System Logs |
| Custom | Select specific areas to clean individually |

<img src="image/cleaner.png" alt="System Cleaner" width="500">

</div>

---

<div align="center">

### Windows/Office Activation (MAS)

Launches [Microsoft Activation Scripts](https://github.com/massgravel/Microsoft-Activation-Scripts) for Windows and Office activation.

</div>

---

<div align="center">

### WinUtil — System Optimization

Runs [Chris Titus Tech's WinUtil](https://github.com/ChrisTitusTech/winutil) for Windows debloating, tweaks, and system optimization.

| Version | Source |
|---------|--------|
| Turkish (TR) | [YusufEren97/WinUtil-Turkish-Edition](https://github.com/YusufEren97/WinUtil-Turkish-Edition) |
| English (EN) | [ChrisTitusTech/winutil](https://github.com/ChrisTitusTech/winutil) |

</div>

---

## Project Structure

```
toolbox/
├── tr/                    # Turkish version
│   ├── toolbox            # Main menu script
│   ├── portkiller.bat     # Port Killer module
│   └── cleaner.bat        # System Cleaner module
├── en/                    # English version
│   ├── toolbox            # Main menu script
│   ├── portkiller.bat     # Port Killer module
│   └── cleaner.bat        # System Cleaner module
├── image/                 # Screenshots
│   ├── toolbox.png
│   ├── portkiller.png
│   └── cleaner.png
└── README.md
```

---

## Encoding & Compatibility

> [!IMPORTANT]
> Always use `git clone` to download this project. This is the only method that guarantees correct UTF-8 encoding for all files.
>
> ```
> git clone https://github.com/YusufEren97/windows-toolbox.git
> ```

Both versions include a built-in UTF-8 encoding fix. The toolbox works correctly on **PowerShell 5.1 (Windows PowerShell)** and **PowerShell 7+** without any additional configuration.

If you downloaded via ZIP or FTP and the ASCII art appears broken:

- **Notepad++** — Encoding → Convert to UTF-8, then save.
- **VS Code** — Click the encoding label in the status bar → Reopen with Encoding → UTF-8.
- **FileZilla** — Set the transfer type to **Binary** under Edit → Settings → Transfers → File Types.

---

## Requirements

| Component | Requirement |
|-----------|-------------|
| **OS** | Windows 10 / 11 |
| **PowerShell** | 5.1 or later |
| **Privileges** | Administrator |

---

## License

This project is open source. Feel free to use and modify.

---

<div align="center">

## Author

| <img src="https://github.com/YusufEren97.png" width="120" style="border-radius:50%"/> |
|:---:|
| **Yusuf Eren Seyrek** |
| [![GitHub](https://img.shields.io/badge/GitHub-YusufEren97-black?logo=github)](https://github.com/YusufEren97) |

</div>
