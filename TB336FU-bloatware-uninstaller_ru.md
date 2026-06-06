[🇬🇧 Read in English](TB336FU-bloatware-uninstaller.md)
# 🧹 Удаление Bloatware для TB336FU

Легковесный портативный скрипт для удаления предустановленного мусорного ПО (bloatware) с **Lenovo Xiaoxin Pad 2025 (TB336FU)** и других Android-планшетов через ADB. Двуязычный интерфейс (английский/русский).

---
[Ссылка для скачивания](https://github.com/Jla3apyc/TB335FC-Toolkit/releases/tag/TB336FU-bloatware-uninstaller)
---

> ⚠️ **ОТКАЗ ОТ ОТВЕТСТВЕННОСТИ: ВСЕ ДЕЙСТВИЯ НА СВОЙ СТРАХ И РИСК!**  
> Инструмент удаляет системные приложения через `pm uninstall --user 0`. Приложения удаляются **только для текущего пользователя** и могут быть восстановлены через ADB. Однако удаление некоторых пакетов может повлиять на стабильность системы или OTA-обновления. **Всегда просматривайте список пакетов перед запуском.**

---

## ✨ Возможности

- 🚀 **Без установки:** Просто распакуйте утилиту и запустите `TB336FU_bloatware_uninstaller.bat`.
- 🌐 **Двуязычность:** Нативный русский и английский интерфейс с ручным выбором языка.
- 🛡️ **Безопасное удаление:** Использует `pm uninstall --user 0` — приложения можно восстановить позже.
- 🔍 **Проверка устройства:** Проверяет подключение ADB перед продолжением.
- 📖 **Встроенная справка:** Пошаговое руководство по включению отладки по USB, если устройство не обнаружено.
- 🎯 **Точечное воздействие:** Специально настроено для bloatware Lenovo Xiaoxin Pad 2025.

---

## 📋 Требования

1. **Windows 10 / 11**
2. Установленные **ADB-драйверы** на ПК (MediaTek VCOM или Google USB Driver)
3. **Platform Tools (adb.exe)** — поместите в подпапку `adb`
4. **Отладка по USB включена** на планшете (см. инструкцию ниже)

---

## 📦 Структура проекта

```text
TB336FU_bloatware_uninstaller/
├── 📄 TB336FU_bloatware_uninstaller.bat   # Основной скрипт (двуязычный)
├── 📄 README_RU.md                        # Эта документация
└── 📁 adb/                                # ⬇️ Сюда поместите Platform Tools
    ├── adb.exe                            # (с developer.android.com)
    ├── AdbWinApi.dll
    └── AdbWinUsbApi.dll
```

> 💡 **Совет:** Скачайте Platform Tools с [developer.android.com/tools/releases/platform-tools](https://developer.android.com/tools/releases/platform-tools) и распакуйте только `adb.exe` и два DLL-файла в папку `adb`.

---

## 🚀 Как использовать

### Шаг 1: Включите отладку по USB на планшете

1. Откройте **Настройки → О планшете**
2. Нажмите на **Версия ПО** 7 раз, пока не появится "Вы стали разработчиком!"
3. Вернитесь в **Настройки → Система → Для разработчиков**
4. Включите **Отладка по USB**
5. Подключите планшет к ПК через USB
6. Разрешите отладку в появившемся окне на экране планшета

### Шаг 2: Запустите скрипт

1. **Запустите** `TB336FU_bloatware_uninstaller.bat`
2. **Выберите язык** (1 — English, 2 — Русский)
3. **Подтвердите**, что ваше устройство отображается в списке ADB
4. Скрипт автоматически удалит все пакеты из списка

---

## 📦 Удаляемые пакеты по умолчанию

Скрипт удаляет следующий bloatware. Вы можете **отредактировать `.bat` файл**, чтобы настроить список.

### 🔴 Приложения Google
| Пакет | Описание |
|-------|----------|
| `com.google.android.apps.books` | Google Play Книги |
| `com.google.android.apps.chromecast.app` | Google Home |
| `com.google.android.apps.kids.home` | Google Детское пространство |
| `com.google.android.apps.magazines` | Google Новости |
| `com.google.android.apps.messaging` | Google Сообщения |
| `com.google.android.apps.photos` | Google Фото |
| `com.google.android.apps.subscriptions.red` | Google One |
| `com.google.android.apps.tachyon` | Google Duo |
| `com.google.android.apps.youtube.kids` | YouTube Kids |
| `com.google.android.apps.youtube.music.setupwizard` | Настройка YouTube Music |
| `com.google.android.contacts` | Google Контакты |
| `com.google.android.feedback` | Отчеты о сбоях |
| `com.google.android.play.games` | Google Play Игры |
| `com.google.android.videos` | Google Play Фильмы |

### 🟠 Приложения Lenovo
| Пакет | Описание |
|-------|----------|
| `com.lenovo.appdaily` | Lenovo Daily (лента новостей) |
| `com.lenovo.dsa` | Device Smart Assistant |
| `com.lenovo.ota` | OTA-обновления Lenovo |
| `com.tblenovo.center` | Lenovo Center |
| `com.tblenovo.lenovowhatsnew` | Lenovo Что нового |
| `com.myscript.calculator.lenovo` | Калькулятор Lenovo |
| `com.myscript.nebo.lenovo` | Nebo (заметки) |

### 🟡 Сторонние приложения
| Пакет | Описание |
|-------|----------|
| `ai.perplexity.app.android` | Perplexity AI |
| `cn.wps.moffice_eng` | WPS Office |
| `com.lemon.lvoverseas` | CapCut |
| `com.opera.preinstall` | Браузер Opera |
| `com.zhiliaoapp.musically` | TikTok |
| `com.mongoosenet.bliss` | Bliss (неизвестно) |

### 🟢 Игры и развлечения
| Пакет | Описание |
|-------|----------|
| `com.agedstudio.board.aged.color.coloring.number.art.paint.draw` | Раскраска по номерам |
| `com.agedstudio.card.solitaire.klondike` | Пасьянс Клондайк |
| `com.block.juggle` | Block Juggle |
| `com.cybercat.acbridge` | Игра AC Bridge |
| `com.oakever.jigsawcard` | Jigsaw Card |
| `com.oakever.tiletrip` | Tile Trip |
| `com.oupeng.sugarburst` | Sugar Burst |
| `com.tripledot.solitaire` | Пасьянс |
| `com.vitastudio.mahjong` | Маджонг |
| `jigsaw.puzzle.game.banana` | Пазл Banana |

### 🔵 Системные компоненты (опционально)
| Пакет | Описание |
|-------|----------|
| `com.android.bookmarkprovider` | Провайдер закладок |
| `com.android.providers.partnerbookmarks` | Партнерские закладки |
| `com.android.providers.partnerbrowsercustomizations` | Настройки партнерского браузера |

> ⚠️ **Примечание:** Удаление системных компонентов может повлиять на работу браузера. Удаляйте их только если уверены.

---

## 🔄 Как восстановить удаленные приложения

Поскольку скрипт использует `pm uninstall --user 0`, все приложения можно восстановить одной ADB-командой:

```bash
adb shell cmd package install-existing <имя_пакета>
```

**Пример:**
```bash
adb shell cmd package install-existing com.google.android.apps.photos
```

**Чтобы восстановить ВСЕ удаленные приложения сразу:**
```bash
for /f "tokens=*" %p in ('adb shell pm list packages -d') do adb shell cmd package install-existing %p
```

---

## 🛠️ Решение проблем

| Проблема | Решение |
|----------|---------|
| `ОШИБКА: adb.exe не найден!` | Скачайте Platform Tools и поместите `adb.exe` + DLL в папку `adb`. |
| Устройство не отображается в ADB | Включите отладку по USB на планшете. Проверьте встроенную справку (нажмите `Н` в запросе). |
| `unauthorized` в ADB | Разблокируйте экран планшета и нажмите "Разрешить отладку USB" в появившемся окне. |
| Приложение возвращается после перезагрузки | Этого не должно происходить с `--user 0`. Если происходит — приложение защищено системой. |
| `Failure [DELETE_FAILED_DEVICE_POLICY_MANAGER]` | Приложение защищено политикой устройства. Без root не удалить. |

---

## 🙏 Благодарности

* Вдохновлено проектом **ADB AppControl** и исследованиями сообщества на **4PDA** и **XDA Developers**.
* Использует официальные **Android Platform Tools** от Google.

> *Этот инструмент предоставляется исключительно в ознакомительных и образовательных целях. Автор не несет ответственности за любой прямой или косвенный ущерб, причиненный вашему устройству.*
