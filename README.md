# system-health-checker

A lightweight, automated system monitoring suite written in Bash. This utility leverages standard Linux tools and background cron daemons to keep a continuous eye on disk and memory usage.

## ✨ Features
* **Automated Disk and memory Auditing**: Regularly checks active storage capacities, filters virtual memory clutter, and logs space alerts if metrics cross critical thresholds.

## 🛠️ Tech Stack & Utilities
* **Language**: Bash Scripting (Linux)
* **Automation**: System Cron Daemon (`crontab`)
* **Core Utilities**: `df`, `awk`, `cut`, `grep`, `ip link`

## 🚀 Quick Setup
1. Clone the repository:
   ```bash
   git clone https://github.com/NiranjanHulamudde/system-health-checker.git
   ```
2. Grant executable permissions to the tracking script:
   ```bash
   chmod +x disk-usagecheck
   ```
3. Set your background automation via `crontab -e`:
   ```text
   * * * * * /path/to/disk-usagecheck >> /path/to/diskreport.txt 2>&1
   ```

   **testing jenkins CI/CD**
