@echo off
chcp 65001 >nul
title 🔄 Region Code Changer
setlocal enabledelayedexpansion

set "ROOT=%~dp0"
set "WORKDIR=%ROOT%"
set "READBACK_DIR=%WORKDIR%readback"
set "PATCHED_DIR=%WORKDIR%patched"
set "SCATTER_DIR=%WORKDIR%image"
set "ADDRESS_DIR=%WORKDIR%image"
set "PROINFO_SRC=%READBACK_DIR%\proinfo"
set "PROINFO_DST=%PATCHED_DIR%\proinfo"
set "SPFT_EXE=%ROOT%SPFlashToolV6.exe"

mkdir "%READBACK_DIR%" 2>nul
mkdir "%PATCHED_DIR%" 2>nul
mkdir "%SCATTER_DIR%" 2>nul

:menu
cls
echo ═════════════════════════════════════════════
echo      🔄 Lenovo Region Code Changer
echo      [UFS/EMMC • proinfo • PowerShell]
echo ═════════════════════════════════════════════
echo.
echo  1. 📥 Find 'proinfo' address in scatter file
echo  2. 📖 Read 'proinfo' [launch 'SP Flash Tool']
echo  3. 🔍 Show current proinfo region
echo  4. ✏️ Patch 'proinfo' [change region code]
echo  5. 📗 Write 'proinfo' [launch 'SP Flash Tool']
echo  6. ℹ️ Device info [from scatter]
echo.
echo  0. Exit
echo.
set /p "CHOICE=Choice: "
if "%CHOICE%"=="1" goto extract_addr
if "%CHOICE%"=="2" goto readback_guide
if "%CHOICE%"=="3" goto show_region
if "%CHOICE%"=="4" goto patch
if "%CHOICE%"=="5" goto write_guide
if "%CHOICE%"=="6" goto info
if "%CHOICE%"=="0" exit /b
goto menu

:extract_addr
cls
echo 🔍 Searching for 'proinfo' address...
echo.
call powershell -NoProfile -ExecutionPolicy Bypass -File "%ROOT%ProinfoTool.ps1" -Action FindAddress -ScatterDir "%SCATTER_DIR%" -OutputFile "%ADDRESS_DIR%\address.txt" -Lang EN
if exist "%ADDRESS_DIR%\address.txt" (
    set /p ADDR=<"%ADDRESS_DIR%\address.txt"
    echo.
    echo ✅ Address found: !ADDR!
    echo    [Memory region is determined from scatter file]
) else (
    echo.
    echo ⚠️ Address not found automatically.
    set /p "ADDR=Enter address manually [e.g. 0x33e00000]: "
    echo !ADDR! > "%ADDRESS_DIR%\address.txt"
    echo ✅ Saved: !ADDR!
)
pause
goto menu

:readback_guide
cls
echo ═════════════════════════════════════════════
echo   📖 READING 'proinfo' via 'SP Flash Tool'
echo ═════════════════════════════════════════════
echo.
echo 📋 Steps:
echo    1. In 'SP Flash Tool' go to 'Readback' tab
echo    2. On the opened tab select 🧿 'Auto'
echo    3. Click 'Read PT' button
echo    4. Connect the POWERED OFF tablet to PC via cable
echo    5. Wait for the file list to load and select 🧿 'proinfo'
echo    6. Click 'Read Back'
echo    7. Wait for the green checkmark ✅ and close 'SP Flash Tool'
echo    8. The file will be saved to: %READBACK_DIR%
echo.
if exist "%SPFT_EXE%" (
    echo 🚀 Launching: %SPFT_EXE%
    start "" "%SPFT_EXE%"
) else (
    echo ❌ SPFlashToolV6.exe not found in: %ROOT%
    echo    Download and extract 'SP Flash Tool' to the folder with this script.
)
pause
goto menu

:show_region
cls
echo 🔍 Reading current region...
echo.
if not exist "!PROINFO_SRC!" (
    echo ⚠️  'proinfo' file not found in: !READBACK_DIR!
    echo    First make a dump via item 2 of the main menu.
    echo.
    pause
    goto menu
)
call powershell -NoProfile -ExecutionPolicy Bypass -File "%ROOT%ProinfoTool.ps1" -Action GetCurrentRegion -InputFile "!PROINFO_SRC!" -Lang EN
echo.
pause
goto menu

:patch
cls
echo ═════════════════════════════════════════════
echo       ✏️  Patching 'proinfo' file
echo ═════════════════════════════════════════════
echo.

set "FILE_EXISTS=0"
if exist "!PROINFO_SRC!" set "FILE_EXISTS=1"

if "!FILE_EXISTS!"=="0" (
    echo ⚠️  'proinfo' file not found in: !READBACK_DIR!
    echo    First make a dump via item 2 of the main menu.
    echo.
)

echo 📋 Enter region code:
echo    CN GB US [or any other 2-letter code]
echo.

:region_input
set "INPUT="
set /p "INPUT=Enter region code: "

:: Format check via PowerShell
powershell -NoProfile -Command "exit $(if ('!INPUT!' -match '^[A-Za-z]{2}$') {0} else {1})" >nul 2>&1
if errorlevel 1 (
    echo ❌ Code must be exactly 2 Latin letters.
    echo.
    pause
    goto menu
)

echo.
echo 🔄 Patching: !INPUT!XX ...
echo.

if exist "!PROINFO_DST!" del "!PROINFO_DST!"

call powershell -NoProfile -ExecutionPolicy Bypass -File "%ROOT%ProinfoTool.ps1" -Action Patch -InputFile "!PROINFO_SRC!" -OutputFile "!PROINFO_DST!" -RegionCode "!INPUT!" -Lang EN
set "PS_RESULT=!ERRORLEVEL!"

if !PS_RESULT! neq 0 (
    echo.
    echo ❌ Patching failed [error code: !PS_RESULT!]
    echo    See PowerShell messages above.
    echo.
    pause
    goto menu
)

if not exist "!PROINFO_DST!" (
    echo ❌ Patching failed. File not created.
    echo    See errors above.
    echo.
    pause
    goto menu
)

for %%F in ("!PROINFO_DST!") do set "FSIZE=%%~zF"
echo.
echo ✅ Done: !PROINFO_DST!
echo    Size: !FSIZE! bytes
echo.
echo 📤 Now flash the file via item 5 of the main menu.
echo.
pause
goto menu

:write_guide
cls
echo ═════════════════════════════════════════════
echo   📗 WRITING 'proinfo' via 'SP Flash Tool'
echo ═════════════════════════════════════════════
echo.

if not exist "%ADDRESS_DIR%\address.txt" (
    echo ⚠️  ERROR: Address file not found!
    echo    First run item 1 of the main menu to extract address from scatter file.
    echo    Writing to wrong address = 100%% brick!
    echo.
    pause
    goto menu
)

for /f "usebackq delims=" %%A in ("%ADDRESS_DIR%\address.txt") do set "ADDR=%%A"
if "!ADDR!"=="" (
    echo ⚠️  ERROR: address.txt file is empty.
    echo    Run item 1 of the main menu to correctly extract the address.
    echo.
    pause
    goto menu
)

echo 📋 Steps:
echo    1. In 'SP Flash Tool' press: Ctrl+Alt+V, then Ctrl+Alt+W
echo       ['Write Memory' tab will open]
echo    2. Fill in the fields:
echo       • File Path:         %PATCHED_DIR%\proinfo
echo       • Begin Address:     %ADDR%
echo         File with address: %ADDRESS_DIR%\address.txt]
echo       • Region:            For TB335FC it's UFS_LUA2, for other devices
echo         choose UFS_LUA2 or EMMC_USER from item 6 of the main menu
echo    3. Click 'Write Memory'
echo    4. Connect the POWERED OFF tablet to PC via cable
echo    5. Wait for the green checkmark ✅ and close 'SP Flash Tool'
echo.
echo ⚠️  CRITICALLY IMPORTANT:
echo    • File must be pre-patched [item 4 of the main menu]
echo    • Do not disconnect the tablet during writing — risk of brick!
echo    • After flashing, Google Play data reset may be needed
echo.
if exist "%SPFT_EXE%" (
    echo 🚀 Launching: %SPFT_EXE%
    start "" "%SPFT_EXE%"
) else (
    echo ❌ SPFlashToolV6.exe not found in: %ROOT%
    echo    Download and extract 'SP Flash Tool' to the folder with this script.
)
pause
goto menu

:info
cls
echo ═════════════════════════════════════════════
echo      ℹ️  Information from scatter file
echo ═════════════════════════════════════════════
echo.
call powershell -NoProfile -ExecutionPolicy Bypass -File "%ROOT%ProinfoTool.ps1" -Action GetScatterInfo -ScatterDir "%SCATTER_DIR%" -Lang EN
if errorlevel 1 (
    echo ⚠️  Failed to read scatter file.
    echo    Put scatter file [XML or TXT] in folder: %SCATTER_DIR%
)
pause
goto menu