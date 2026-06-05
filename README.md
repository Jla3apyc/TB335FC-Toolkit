[Русскоязычная версия](README_RU.md)
# 🛠️ Lenovo Xiaoxin Pad (TB335FC) Toolkit & Guides

A collection of utilities and detailed guides for managing, modifying, and flashing MediaTek-based devices (MT6835), with a focus on the **Lenovo Xiaoxin Pad 2025 (TB335FC)**.

> ⚠️ **IMPORTANT:** All actions are performed at your own risk. Modifying system partitions may result in warranty void or bricking your device. **Always make backups before proceeding.**

---

## 📚 Projects

This toolkit consists of two interconnected projects. Choose the one that matches your task:

### 📖 1. [TB335FC-flash-guide](TB335FC-flash-guide.md)
A step-by-step guide for complete flashing, recovery, and device maintenance using SP Flash Tool.
* **Purpose:** Install stock or custom firmware, recover device after failed modifications (unbrick), install MediaTek VCOM drivers.
* **Features:** Detailed screenshots, scatter file structure explanation, SLA/DA authentication bypass methods.

### 🌍 2. [TB335FC-region-code-changer](TB335FC-region-code-changer.md)
A minimalist, portable, and safe tool for changing the region code in the `proinfo` partition.
* **Purpose:** Activate Widevine L1 (HD video), Google Play certification, change regional settings.
* **Features:** No Python required, works via built-in PowerShell, automatically reads scatter files, bilingual interface (RU/EN), and built-in input validation.

---

## 🙏 Credits
* The logic is inspired by **SP Flash Tool**, **LPMBox** projects and community research on **4PDA**.
* Thanks to all enthusiasts who share knowledge about the MediaTek platform.
> *This project is provided for educational and informational purposes only. The author is not responsible for any direct or indirect damage caused to your device.*
