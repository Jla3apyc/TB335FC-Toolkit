[🇷🇺 Читать на русском](TB335FC-flash-guide_ru.md)
# Lenovo Xiaoxin Pad 11 2025 (TB335FC) flash guide
Instructions for flashing the Lenovo Xiaoxin Pad 11 2025 (TB335FC - China) with the Lenovo Tab K11 Gen 2 (TB336FU - Global) firmware
---
[Download link](https://github.com/Jla3apyc/TB335FC-flash-guide/releases/tag/TB335FC-flash-guide)
---
# ⚠️ Warning Before You Start
> - Incorrect flashing can **permanently brick your device**
> - Ensure your tablet is charged to **at least 50%**
> - Back up all important data beforehand
> - Proceed **at your own risk**

## ✅ What you'll get
- Global firmware with Google Play & multi-language support

## ❌ What doesn't work
- OTA updates

## 📦 What You'll Need
- Firmware: `TB336FU_ZUI_17.5.10.213` (main)
- Firmware: `TB335FC_ZUXOS_1.5.10.172` (source for `dtbo.img`)
- Flashing tool: `SP Flash Tool v6` (usually included in firmware folder)
- Drivers: `MTK Driver Setup.exe`
- Custom scatter file: MT6835_Android_scatter.xml (it has enabled flashing of slots A and B)
- USB cable and a **powered-off** tablet

## 🔧 Step-by-Step Guide
1. Extract both firmware packages into **separate folders** on your PC
2. Install `MTK Drivers`
3. Copy the `dtbo.img` file from `TB335FC_ZUXOS_1.5.10.172/image/` to `TB336FU_ZUI_17.5.10.213/image/` (**overwrite** the existing file)
4. Place the custom scatter file `MT6835_Android_scatter.xml` into `TB336FU_ZUI_17.5.10.213/image/`
5. Launch the flashing tool `SPFlashToolV6.exe` from the `TB336FU_ZUI_17.5.10.213`
6. Configure `SP Flash Tool`:
   - In the `Battery` section, check the `Auto detect` box
   - In the `Download-XML` section, select: `image\download_agent\flash.xml`
   - In the `Authentication File` section, select: `image\download_agent\da.auth`
7. Select flashing mode:
   - Go to the `Download` tab
   - Choose: `Firmware Upgrade` (all user data will be erased) or `Download Only` (you can uncheck `userdata` box to keep user data)
8. Start flashing:
   - Click the `Download` button
   - Connect your **powered-off** tablet via USB
   - Wait for completion (green checkmark ✅ will appear) 

## ❗ Critical Notes
- 🔄 Copy **only** `dtbo.img` and `MT6835_Android_scatter.xml` — do not replace any other files!
- ☑️ **Do not uncheck** any items in `SP Flash Tool` unless you fully understand the consequences
- 🔌 Never disconnect the tablet until the process is 100% complete

> 💡 **Compatibility Note:** This method also works with:
> `TB336FU_ZUI_17.5.10.085` + `TB335FC_ZUXOS_1.5.10.057`

## 🙏 Credits
- The logic is inspired by the **LPMBox** project and community research on **4PDA**.
- The tool is designed with a focus on safety, transparency, and ease of use.
- *This tool is provided for educational purposes. The author is not responsible for any damage caused to your device.*

[YouTube](https://www.youtube.com/watch?v=mYe1XaooGX4)
