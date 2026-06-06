[🇷🇺 Читать на русском](TB336FU-bloatware-uninstaller_ru.md)
# 🧹 TB336FU bloatware uninstaller

A lightweight, portable batch script for removing pre-installed bloatware from **Lenovo Xiaoxin Pad 2025 (TB336FU firmware)** and other Android tablets using ADB. Bilingual interface (English/Russian).

---
[Link to the release](https://github.com/Jla3apyc/TB335FC-Toolkit/releases/tag/TB336FU-bloatware-uninstaller)
---

> ⚠️ **DISCLAIMER: USE AT YOUR OWN RISK!**  
> This tool removes system apps using `pm uninstall --user 0`. The apps are removed **only for the current user** and can be restored via ADB. However, removing certain packages may affect system stability or OTA updates. **Always review the list of packages before running.**

---

## ✨ Features

- 🚀 **Zero Installation:** Just unpack the utility and run `TB336FU_bloatware_uninstaller.bat`.
- 🌐 **Bilingual:** Native English and Russian interface with manual language selection.
- 🛡️ **Safe Removal:** Uses `pm uninstall --user 0` — apps can be restored later.
- 🔍 **Device Verification:** Checks ADB connection before proceeding.
- 📖 **Built-in Help:** Step-by-step guide for enabling USB Debugging if the device is not detected.
- 🎯 **Targeted:** Specifically tuned for Lenovo Xiaoxin Pad 2025 bloatware.

---

## 📋 Prerequisites

1. **Windows 10 / 11**
2. **ADB drivers** installed on your PC (MediaTek VCOM or Google USB Driver)
3. **Platform Tools (adb.exe)** — already in the `adb` subfolder
4. **USB Debugging enabled** on the tablet (see instructions below)

---

## 📦 Project Structure

```text
TB336FU_bloatware_uninstaller/
├── 📄 TB336FU_bloatware_uninstaller.bat      # Main script (bilingual)
├── 📄 README.md                     # This documentation
└── 📁 adb/                          # ⬇️ Place Platform Tools here
    ├── adb.exe                      # (from developer.android.com)
    ├── AdbWinApi.dll
    └── AdbWinUsbApi.dll
```

## 🚀 How to Use

### Step 1: Enable USB Debugging on Your Tablet

1. Open **Settings → About tablet**
2. Tap **Software version** 7 times until "You are now a developer!" appears
3. Return to **Settings → System → Developer options**
4. Enable **USB Debugging**
5. Connect the tablet to your PC via USB
6. Allow the debugging prompt on the tablet screen when it appears

### Step 2: Run the Script

1. **Run** `TB336FU_bloatware_uninstaller.bat`
2. **Select language** (1 for English, 2 for Russian)
3. **Confirm** that your device appears in the ADB devices list
4. The script will automatically remove all packages from the list

---

## 📦 Packages Removed by Default

The script removes the following bloatware. You can **edit the `.bat` file** to customize the list.

### 🔴 Google Apps
| Package | Description |
|---------|-------------|
| `com.google.android.apps.books` | Google Play Books |
| `com.google.android.apps.chromecast.app` | Google Home |
| `com.google.android.apps.kids.home` | Google Kids Space |
| `com.google.android.apps.magazines` | Google News |
| `com.google.android.apps.messaging` | Google Messages |
| `com.google.android.apps.photos` | Google Photos |
| `com.google.android.apps.subscriptions.red` | Google One |
| `com.google.android.apps.tachyon` | Google Duo |
| `com.google.android.apps.youtube.kids` | YouTube Kids |
| `com.google.android.apps.youtube.music.setupwizard` | YouTube Music Setup |
| `com.google.android.contacts` | Google Contacts |
| `com.google.android.feedback` | Crash Reports |
| `com.google.android.play.games` | Google Play Games |
| `com.google.android.videos` | Google Play Movies |

### 🟠 Lenovo Apps
| Package | Description |
|---------|-------------|
| `com.lenovo.appdaily` | Lenovo Daily (news feed) |
| `com.lenovo.dsa` | Device Smart Assistant |
| `com.lenovo.ota` | Lenovo OTA Updates |
| `com.tblenovo.center` | Lenovo Center |
| `com.tblenovo.lenovowhatsnew` | Lenovo What's New |
| `com.myscript.calculator.lenovo` | Lenovo Calculator |
| `com.myscript.nebo.lenovo` | Nebo (note-taking) |

### 🟡 Third-Party Apps
| Package | Description |
|---------|-------------|
| `ai.perplexity.app.android` | Perplexity AI |
| `cn.wps.moffice_eng` | WPS Office |
| `com.lemon.lvoverseas` | CapCut |
| `com.opera.preinstall` | Opera Browser |
| `com.zhiliaoapp.musically` | TikTok |

### 🟢 Games & Entertainment
| Package | Description |
|---------|-------------|
| `com.agedstudio.board.aged.color.coloring.number.art.paint.draw` | Color by Number |
| `com.agedstudio.card.solitaire.klondike` | Solitaire Klondike |
| `com.mongoosenet.bliss` | Bliss |
| `com.block.juggle` | Block Juggle |
| `com.cybercat.acbridge` | AC Bridge game |
| `com.oakever.jigsawcard` | Jigsaw Card |
| `com.oakever.tiletrip` | Tile Trip |
| `com.oupeng.sugarburst` | Sugar Burst |
| `com.tripledot.solitaire` | Solitaire |
| `com.vitastudio.mahjong` | Mahjong |
| `jigsaw.puzzle.game.banana` | Banana Jigsaw Puzzle |

### 🔵 System Components (Optional)
| Package | Description |
|---------|-------------|
| `com.android.bookmarkprovider` | Bookmark Provider |
| `com.android.providers.partnerbookmarks` | Partner Bookmarks |
| `com.android.providers.partnerbrowsercustomizations` | Partner Browser Customizations |

---

## 🛠️ Troubleshooting

| Issue | Solution |
|-------|----------|
| `ERROR: adb.exe not found!` | Download Platform Tools and place `adb.exe` + DLLs in the `adb` folder. |
| Device not listed in ADB | Enable USB Debugging on the tablet. Check the built-in help (press `N` when prompted). |
| `unauthorized` in ADB | Unlock the tablet screen and tap "Allow USB debugging" on the prompt. |
| App reappears after reboot | This should not happen with `--user 0`. If it does, the app may be protected by the system. |
| `Failure [DELETE_FAILED_DEVICE_POLICY_MANAGER]` | The app is protected by device policy. Cannot be removed without root. |

---

## 🙏 Credits

* Inspired by the **ADB AppControl** project and community research on **4PDA** and **XDA Developers**.
* Uses official **Android Platform Tools** from Google.

> *This tool is provided for educational and informational purposes only. The author is not responsible for any direct or indirect damage caused to your device.*
