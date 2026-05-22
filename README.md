# Windows 11 Optimisation Toolkit

A professional PowerShell-based Windows 11 optimisation toolkit focused on performance, privacy, developer productivity, and reducing unnecessary AI and telemetry overhead.

Built for engineers, developers, architects, power users, and enterprise environments.

---

## Features

### AI & Copilot Removal
- Disables Windows Copilot
- Disables Recall-related AI policies
- Removes AI-related background integrations

### Performance Optimisation
- Enables Ultimate Performance power plan
- Optimises visual effects
- Reduces startup overhead
- Cleans temporary files
- Disables unnecessary indexing services

### Telemetry Reduction
- Disables Windows telemetry services
- Reduces background data collection
- Disables consumer experience tracking

### Windows Debloat
- Removes unnecessary Microsoft apps
- Removes Widgets and News feeds
- Removes Xbox and consumer gaming components
- Removes Clipchamp and bundled apps

### Developer Workstation Friendly
- Lightweight and script-based
- Designed for engineering/dev environments
- Useful for Hyper-V, WSL, Docker, IaC, DevOps, and cloud engineering workflows

---

## Included Script

| Script | Description |
|---|---|
| `Optimise-Windows11.ps1` | Main optimisation and debloat script |

---

## Usage

Run PowerShell as Administrator.

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
.\Optimise-Windows11.ps1
```

Reboot the machine after completion.

---

## Recommended Environment

- Windows 11 Pro / Enterprise
- Developer workstations
- Cloud engineering systems
- Gaming systems
- Virtualisation hosts
- AI/dev laptops

---

## Important Notes

This script modifies:

- Windows policies
- Services
- App packages
- Registry settings
- Performance configuration

Always review scripts before execution.

A restore point is created automatically where supported.

---

## Roadmap

Planned future additions:

- Gaming optimisation profile
- Enterprise baseline profile
- Privacy hardened profile
- Rollback script
- Logging/report generation
- Winget cleanup integration
- Service tuning profiles
- WSL/Docker optimisation
- GitHub Actions validation

---

## Why This Exists

Modern Windows installations increasingly prioritise cloud-connected services, telemetry, AI integrations, and consumer features.

For professional workloads, many of these services are unnecessary and consume:

- CPU cycles
- RAM
- Storage
- Network activity
- Battery life

This toolkit focuses on giving control back to the user.

---

## Author

Adam Anderson  
Cloud Architect | Infrastructure Engineer | Founder of SpaceNet-IT

---

## License

MIT License
