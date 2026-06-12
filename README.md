[Russian version](README_RU.md)

# 🛠️ Lenovo Xiaoxin Pad (TB335FC) Toolkit & Guides

A collection of utilities and detailed guides for managing, modifying, and flashing MediaTek-based devices (MT6835), with a focus on the **Lenovo Xiaoxin Pad 2025 (TB335FC)**.

> ⚠️ **IMPORTANT:** All actions are performed at your own risk. Modifying system partitions may result in a voided warranty or bricking your device. **Always make backups before proceeding.**

---

## 📚 Projects

This toolkit consists of interconnected projects. Choose the one that matches your task:

### 📖 1. [TB335FC flash guide](TB335FC-flash-guide.md)
A step-by-step guide for complete flashing, recovery, and device maintenance using SP Flash Tool.
* **Purpose:** Installing the global TB336FU firmware on the Chinese TB335FC tablet, and recovering the device after failed modifications (unbrick).
* **Features:** Utilizes a new, custom method for installing the global firmware on the Chinese tablet.

### 🌍 2. [TB335FC region code changer](TB335FC-region-code-changer.md)
A tool for changing the region code in the `proinfo` partition.
* **Purpose:** Activating Widevine L1 (HD video), Google Play certification, and changing regional settings.
* **Features:** Does not require Python, runs via built-in PowerShell. Automatically reads scatter files.

### 🧹 3. [TB336FU bloatware uninstaller](TB336FU-bloatware-uninstaller.md)
A script for disabling OTA updates and removing pre-installed bloatware.
* **Purpose:** Automatically disables non-functional OTA updates and facilitates the removal of pre-installed bloatware from the Lenovo Xiaoxin Pad 2025 (TB336FU firmware) via ADB.
* **Features:** Designed for the TB336FU ZUI_17.5.10.213 firmware installed on the TB335FC tablet. Uses safe removal via `pm uninstall --user 0` with the ability to fully restore applications. Easily configurable by editing the package list in the `.bat` file.

---

## 🙏 Acknowledgments
* The logic is inspired by the **SP Flash Tool, ADB AppControl, LPMBox** projects, and community research on **4PDA**.
* Thanks to all the enthusiasts who share their knowledge about the MediaTek platform.

> *This project is provided exclusively for informational and educational purposes. The author is not responsible for any direct or indirect damage caused to your device.*
### 🌍 2. [TB335FC region code changer](TB335FC-region-code-changer.md)
A minimalist, portable, and safe tool for changing the region code in the `proinfo` partition.
* **Purpose:** Activate Widevine L1 (HD video), Google Play certification, change regional settings.
* **Features:** No Python required, works via built-in PowerShell. Automatically reads scatter files.

### 🧹 3. [TB336FU bloatware uninstaller](TB336FU-bloatware-uninstaller.md)
A lightweight, portable script for removing pre-installed bloatware.
* **Purpose:** Facilitates the removal of pre-installed bloatware from Lenovo Xiaoxin Pad 2025 (TB336FU firmware) and other Android tablets via ADB.
* **Features:** Developed for the TB336FU ZUI_17.5.10.213 firmware installed on the TB335FC. It uses safe uninstallation via `pm uninstall --user 0` with the ability to fully restore apps. It's easily configured by editing the package list in a `.bat` file.
---

## 🙏 Credits
* The logic is inspired by **SP Flash Tool, ADB AppControl, LPMBox** projects and community research on **4PDA**.
* Thanks to all enthusiasts who share knowledge about the MediaTek platform.
> *This project is provided for educational and informational purposes only. The author is not responsible for any direct or indirect damage caused to your device.*
