# TB335FC-flash-guide
Instructions for flashing the Lenovo Xiaoxin Pad 11 2025 (China) with the Lenovo Tab K11 Gen 2 (Global) firmware

# ⚠️ Warning Before You Start
> - Incorrect flashing can **permanently brick your device**
> - Ensure your tablet is charged to **at least 50%**
> - Back up all important data beforehand
> - Proceed **at your own risk**

## 📦 What You'll Need
- Firmware: `TB336FU_ZUI_17.5.10.213` (main)
- Firmware: `TB335FC_ZUXOS_1.5.10.172` (source for `dtbo.img`)
- Flashing tool: `SP Flash Tool v6` (usually included in firmware folder)
- Drivers: `MTK Driver Setup.exe`
- Custom scatter file: [MT6835_Android_scatter.xml](https://github.com/user-attachments/files/28256549/MT6835_Android_scatter.xml)
- USB cable and a **powered-off** tablet

## 🔧 Step-by-Step Guide
1. Extract both firmware packages into **separate folders** on your PC
2. Install `MTK Drivers`
3. Copy the `dtbo.img` file from `TB335FC_ZUXOS_1.5.10.172/image/` to `TB336FU_ZUI_17.5.10.213/image/` (**overwrite** the existing file)
4. Place the custom scatter file `MT6835_Android_scatter.xml` into `TB336FU_ZUI_17.5.10.213/image/`
5. Launch the flashing tool `SPFlashToolV6.exe` from the `TB336FU_ZUI_17.5.10.213`
6. Configure **SP Flash Tool**:
   - In the **"Battery"** section, check the **"Auto detect"** box
   - In the **"Download-XML"** section, select: `image\download_agent\flash.xml`
   - In the **"Authentication File"** section, select: `image\download_agent\da.auth`
7. Select flashing mode:
   - Go to the **"Download"** tab
   - Choose: **"Firmware Upgrade"** (all user data will be erased) or **"Download Only"** (you can uncheck `userdata` box to keep user data)
8. Start flashing:
   - Click the **"Download"** button
   - Connect your **powered-off** tablet via USB
   - Wait for completion (green checkmark ✅ will appear) 

## ❗ Critical Notes
- 🔄 Copy **only** `dtbo.img` and `MT6835_Android_scatter.xml` — do not replace any other files!
- ☑️ **Do not uncheck** any items in the flashing tool unless you fully understand the consequences
- 🔌 Never disconnect the tablet until the process is 100% complete

> 💡 **Compatibility Note:** This method also works with:
> `TB336FU_ZUI_17.5.10.085` + `TB335FC_ZUXOS_1.5.10.057`
