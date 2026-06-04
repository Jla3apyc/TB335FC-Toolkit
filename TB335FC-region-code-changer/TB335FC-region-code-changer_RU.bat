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
echo  1. 📥 Найти адрес 'proinfo' в scatter-файле
echo  2. 📖 Чтение 'proinfo' [запуск 'SP Flash Tool']
echo  3. 🔍 Показать текущий регион proinfo
echo  4. ✏️ Запатчить 'proinfo' [сменить код региона]
echo  5. 📗 Запись 'proinfo' [запуск 'SP Flash Tool']
echo  6. ℹ️ Информация об устройстве [из scatter]
echo.
echo  0. Выход
echo.
set /p "CHOICE=Выбор: "
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
echo 🔍 Поиск адреса 'proinfo'...
echo.
call powershell -NoProfile -ExecutionPolicy Bypass -File "%ROOT%ProinfoTool.ps1" -Action FindAddress -ScatterDir "%SCATTER_DIR%" -OutputFile "%ADDRESS_DIR%\address.txt" -Lang RU
if exist "%ADDRESS_DIR%\address.txt" (
    set /p ADDR=<"%ADDRESS_DIR%\address.txt"
    echo.
    echo ✅ Адрес найден: !ADDR!
    echo    [Регион памяти определяется из scatter-файла]
) else (
    echo.
    echo ⚠️ Адрес не найден автоматически.
    set /p "ADDR=Введите адрес вручную [например 0x33e00000]: "
    echo !ADDR! > "%ADDRESS_DIR%\address.txt"
    echo ✅ Сохранено: !ADDR!
)
pause
goto menu

:readback_guide
cls
echo ═════════════════════════════════════════════
echo   📖 ЧТЕНИЕ 'proinfo' через 'SP Flash Tool'
echo ═════════════════════════════════════════════
echo.
echo 📋 Порядок действий:
echo    1. В 'SP Flash Tool' перейдите на вкладку 'Readback'
echo    2. На открывшейся вкладке выберите 🧿 'Auto'
echo    3. Нажмите кнопку 'Read PT'
echo    4. Подключите ВЫКЛЮЧЕННЫЙ планшет к ПК кабелем
echo    5. Дождитесь загрузки списка файлов и выберите 🧿 'proinfo'
echo    6. Нажмите 'Read Back'
echo    7. Дождитесь зелёной галочки ✅ и закройте 'SP Flash Tool'
echo    8. Файл сохранится в папку: %READBACK_DIR%
echo.
if exist "%SPFT_EXE%" (
    echo 🚀 Запускаю: %SPFT_EXE%
    start "" "%SPFT_EXE%"
) else (
    echo ❌ SPFlashToolV6.exe не найден в: %ROOT%
    echo    Скачайте и распакуйте 'SP Flash Tool' в папку с этим скриптом.
)
pause
goto menu

:show_region
cls
echo 🔍 Чтение текущего региона...
echo.
if not exist "!PROINFO_SRC!" (
    echo ⚠️  Файл 'proinfo' не найден в: !READBACK_DIR!
    echo    Сначала сделайте дамп через пункт 2 главного меню.
    echo.
    pause
    goto menu
)
call powershell -NoProfile -ExecutionPolicy Bypass -File "%ROOT%ProinfoTool.ps1" -Action GetCurrentRegion -InputFile "!PROINFO_SRC!" -Lang RU
echo.
pause
goto menu

:patch
cls
echo ═════════════════════════════════════════════
echo       ✏️  Патчинг файла 'proinfo'
echo ═════════════════════════════════════════════
echo.

set "FILE_EXISTS=0"
if exist "!PROINFO_SRC!" set "FILE_EXISTS=1"

if "!FILE_EXISTS!"=="0" (
    echo ⚠️  Файл 'proinfo' не найден в: !READBACK_DIR!
    echo    Сначала сделайте дамп через пункт 2 главного меню.
    echo.
)

echo 📋 Введите код региона:
echo    CN GB US [или любой другой 2-буквенный код]
echo.

:region_input
set "INPUT="
set /p "INPUT=Введите код региона: "

:: Проверка формата через PowerShell
powershell -NoProfile -Command "exit $(if ('!INPUT!' -match '^[A-Za-z]{2}$') {0} else {1})" >nul 2>&1
if errorlevel 1 (
    echo ❌ Код должен состоять из 2 латинских букв.
    echo.
    pause
    goto menu
)

echo.
echo 🔄 Патчинг: !INPUT!XX ...
echo.

if exist "!PROINFO_DST!" del "!PROINFO_DST!"

call powershell -NoProfile -ExecutionPolicy Bypass -File "%ROOT%ProinfoTool.ps1" -Action Patch -InputFile "!PROINFO_SRC!" -OutputFile "!PROINFO_DST!" -RegionCode "!INPUT!" -Lang RU
set "PS_RESULT=!ERRORLEVEL!"

if !PS_RESULT! neq 0 (
    echo.
    echo ❌ Патчинг не удался [код ошибки: !PS_RESULT!]
    echo    Смотрите сообщения PowerShell выше.
    echo.
    pause
    goto menu
)

if not exist "!PROINFO_DST!" (
    echo ❌ Патчинг не удался. Файл не создан.
    echo    Смотрите ошибки выше.
    echo.
    pause
    goto menu
)

for %%F in ("!PROINFO_DST!") do set "FSIZE=%%~zF"
echo.
echo ✅ Готово: !PROINFO_DST!
echo    Размер: !FSIZE! байт
echo.
echo 📤 Теперь прошейте файл через пункт 5 главного меню.
echo.
pause
goto menu

:write_guide
cls
echo ═════════════════════════════════════════════
echo   📗 ЗАПИСЬ 'proinfo' через 'SP Flash Tool'
echo ═════════════════════════════════════════════
echo.

if not exist "%ADDRESS_DIR%\address.txt" (
    echo ⚠️  ОШИБКА: Файл с адресом не найден!
    echo    Сначала выполните пункт 1 главного меню, чтобы извлечь адрес из scatter-файла.
    echo    Запись по неверному адресу = 100%% кирпич!
    echo.
    pause
    goto menu
)

for /f "usebackq delims=" %%A in ("%ADDRESS_DIR%\address.txt") do set "ADDR=%%A"
if "!ADDR!"=="" (
    echo ⚠️  ОШИБКА: Файл address.txt пуст.
    echo    Выполните пункт 1 главного меню для корректного извлечения адреса.
    echo.
    pause
    goto menu
)

echo 📋 Порядок действий:
echo    1. В 'SP Flash Tool' нажмите: Ctrl+Alt+V, затем Ctrl+Alt+W
echo       [откроется вкладка 'Write Memory']
echo    2. Заполните поля:
echo       • File Path:      %PATCHED_DIR%\proinfo
echo       • Begin Address:  %ADDR%
echo         Файл с адресом: %ADDRESS_DIR%\address.txt
echo       • Region:         Для TB335FC это UFS_LUA2, для других устройств
echo         выберите UFS_LUA2 или EMMC_USER по информации из пункта 6 главного меню
echo    3. Нажмите 'Write Memory'
echo    4. Подключите ВЫКЛЮЧЕННЫЙ планшет к ПК кабелем
echo    5. Дождитесь зелёной галочки ✅ и закройте 'SP Flash Tool'
echo.
echo ⚠️  КРИТИЧЕСКИ ВАЖНО:
echo    • Файл должен быть предварительно запатчен [пункт 4 главного меню]
echo    • Не отключайте планшет во время записи — риск кирпича!
echo    • После прошивки может понадобиться сброс данных Google Play
echo.
if exist "%SPFT_EXE%" (
    echo 🚀 Запускаю: %SPFT_EXE%
    start "" "%SPFT_EXE%"
) else (
    echo ❌ SPFlashToolV6.exe не найден в: %ROOT%
    echo    Скачайте и распакуйте 'SP Flash Tool' в папку с этим скриптом.
)
pause
goto menu

:info
cls
echo ═════════════════════════════════════════════
echo      ℹ️  Информация из scatter-файла
echo ═════════════════════════════════════════════
echo.
call powershell -NoProfile -ExecutionPolicy Bypass -File "%ROOT%ProinfoTool.ps1" -Action GetScatterInfo -ScatterDir "%SCATTER_DIR%" -Lang RU
if errorlevel 1 (
    echo ⚠️  Не удалось прочитать scatter-файл.
    echo    Положите scatter-файл [XML или TXT] в папку: %SCATTER_DIR%
)
pause
goto menu