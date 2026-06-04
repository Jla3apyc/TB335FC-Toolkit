[🇷🇺 Читать на русском](TB335FC-region-code-changer_ru.md)
# 🔄 Lenovo Xiaoxin region code changer (TB335FC & MTK Devices)

A minimalist, portable, and safe tool for changing the region code in the `proinfo` partition of MediaTek (MTK) devices. Originally designed for the **Lenovo Xiaoxin Pad 2025 (TB335FC)**, but universally compatible with other MTK devices (UFS/EMMC) when provided with the correct scatter file.

> ⚠️ **DISCLAIMER: USE AT YOUR OWN RISK!**  
> Modifying the `proinfo` partition carries a risk of bricking your device if done incorrectly.  
> **Note:** Changing the region code will likely **stop OTA updates** from working. Always make a full backup before proceeding.

---
[Download link](https://github.com/Jla3apyc/TB335FC-flash-guide/releases/tag/TB335FC-region-code-changer)
---

## ✨ Features

- 🚀 **Zero Installation:** Fully portable. Just unpack and run.
- 🛡️ **Safe & Validated:** Checks file size, validates input (exactly 2 Latin letters), and verifies byte changes before saving.
- 🌐 **Bilingual:** Native support for English and Russian interfaces.
- 🧠 **Smart Detection:** Automatically extracts the correct `proinfo` address and memory region (UFS/EMMC) from your scatter file.
- ⚡ **No External Dependencies:** Uses built-in Windows PowerShell for patching logic. No Python or third-party libraries required.
- 🔗 **SP Flash Tool Integration:** Guides you through the process and can launch SP Flash Tool directly from the menu.

---

## 📋 Prerequisites

1. **Windows 10 / 11** (with default PowerShell 5.1+).
2. **MediaTek VCOM Drivers** installed on your PC.
3. **SP Flash Tool** (v6.x recommended).
4. **Scatter File** (`MTxxxx_Android_scatter.xml`) from your device's firmware.

---

## 📦 Project Structure

```text
Lenovo_Region_Changer/
├── 📄 XiaoxinRegionCodeChanger_EN.bat   # English launcher
├── 📄 XiaoxinRegionCodeChanger_RU.bat   # Russian launcher
├── ⚙️  ProinfoTool.ps1                  # Core patching logic
├── SP_Flash_Tool/                       # ⬇️ Files and folders of 'SP Flash Tool'
├── 📁 image/                            # ⬇️ Place your device's scatter file here
│   └── MT6835_Android_scatter.xml
├── 📁 readback/                         # 🔄 Auto-created (original dump is saved here)
└── 📁 patched/                          # 🔄 Auto-created (patched file appears here)
```
---

## 🚀 How to Use

1. Place your device's **scatter file** into the `image` folder.
2. The root folder already contains **`SP Flash Tool`**.
3. Run `XiaoxinRegionCodeChanger_RU.bat` (or `_EN.bat`).
4. Follow the recommended workflow:
   - **Step 1:** `1` → Find the `proinfo` address in the scatter file.
   - **Step 2:** `2` → Dump (read) the `proinfo` partition via SP Flash Tool.
   - **Step 3:** `4` → Patch the dumped file by entering your desired 2-letter region code (e.g., `GB`, `RU`, `US`).
   - **Step 4:** `5` → Write the patched file back to the device via SP Flash Tool.
   - **Step 5:** `6` → View device info and partition parameters from the scatter file at any time.

---

## ⚠️ Important Notes

- The tool accepts **any 2 Latin letters** (e.g., `GB`, `XY`). It will find *any* existing `XXYY` format token in the file and replace it. If a valid token is not found, the process will safely abort.
- After flashing the new region, go to **Settings → Apps → Google Play Store → Storage → Clear Data** for the changes to take effect.
- **Never** disconnect the USB cable during read or write processes.

---

## 🛠️ Troubleshooting

| Issue | Solution |
|-------|----------|
| `❌ Code must be exactly 2 Latin letters.` | You entered numbers, Cyrillic, or left the field empty. Enter exactly 2 English letters (e.g., `RU`). |
| `❌ Scatter file not found` | Ensure your scatter file (`.txt` or `.xml`) is located inside the `image` folder. |
| `❌ Region token not found in file` | The `proinfo` file may be corrupted, empty, or dumped from a different device. Redump it via SP Flash Tool. |
| `SPFlashToolV6.exe not found` | Download `SP Flash Tool` and unpack it to the same folder as the `.bat` files. |

---

## 🙏 Credits

- The logic is inspired by the **LPMBox** project and community research on **4PDA**.
- The tool is designed with a focus on safety, transparency, and ease of use.
- *This tool is provided for educational purposes. The author is not responsible for any damage caused to your device.*
