# Toolbox

<p align="center">
  <img src="image/toolbox.png" alt="Toolbox" width="600">
</p>

A lightweight Windows utility toolkit that runs directly from PowerShell — no installation required. Provides port management, system cleaning, and Windows/Office activation in a single interactive menu.

Available in **English** and **Turkish**.

---

## Quick Start

Paste one of the following commands into PowerShell and press Enter:

```powershell
irm yusuferenseyrek.com.tr/toolbox | iex
```

> Requires **Administrator privileges** for full functionality.

---

## Modules

### Port Killer v1.0

Manage and terminate processes occupying network ports.

| Feature | Description |
|---------|-------------|
| Kill Port | Terminate the process bound to a specific port |
| Query Port | View PID and process name for a given port |
| List All Ports | Display all listening ports with PID details |
| Safety Protection | Critical system ports (53, 135, 139, 445, 3389) are protected |

<img src="image/portkiller.png" alt="Port Killer" width="500">

### System Cleaner v1.1

Free up disk space and flush caches with three cleaning modes.

| Mode | Targets |
|------|---------|
| Quick | User Temp, Windows Temp, Prefetch, Recycle Bin, DNS Cache |
| Deep | All of the above + Windows Error Reports + System Logs |
| Custom | Select specific areas to clean individually |

<img src="image/cleaner.png" alt="System Cleaner" width="500">

### Windows/Office Activation (MAS)

Launches [Microsoft Activation Scripts](https://github.com/massgravel/Microsoft-Activation-Scripts) for Windows and Office activation.

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

Both versions include a built-in UTF-8 encoding fix. The toolbox works correctly on **PowerShell 5.1 (Windows PowerShell)** and **PowerShell 7+** without any additional configuration.

If you download the project as a ZIP or via FTP and the ASCII art appears broken:

- **Notepad++** — Encoding → Convert to UTF-8, then save.
- **VS Code** — Click the encoding label in the status bar → Reopen with Encoding → UTF-8.
- **FileZilla** — Set the transfer type to **Binary** under Edit → Settings → Transfers → File Types.

> Using `git clone` always preserves the correct encoding.

---

## Requirements

- Windows 10 / 11
- PowerShell 5.1 or later
- Administrator privileges

---

## Author

**YusufEren97** — [yusuferenseyrek.com.tr](https://yusuferenseyrek.com.tr)

## License

This project is open source. Feel free to use and modify.
