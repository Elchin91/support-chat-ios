# Инструкция по созданию IPA для TrollStore

## Что такое TrollStore?

TrollStore - это инструмент для установки IPA файлов на iPhone без джейлбрейка и без сертификата разработчика Apple. Он работает на iOS 14.0 - 16.6.1 (и некоторых версиях iOS 17).

## Требования

### Для сборки:
- macOS (Windows с macOS VM тоже подойдет)
- Xcode 15+ установлен
- Командная строка Xcode tools

### Для установки:
- iPhone с TrollStore
- Способ передачи IPA на телефон (AirDrop, облако, и т.д.)

## Способ 1: Автоматическая сборка (Рекомендуется)

### На macOS/Linux:
```bash
cd "ios app"
chmod +x build-ipa.sh
./build-ipa.sh
```

### На Windows:
```cmd
cd "ios app"
build-ipa.bat
```

## Способ 2: Ручная сборка через Xcode

### Шаг 1: Откройте проект
```bash
cd "ios app/SupportChat"
open SupportChat.xcodeproj
```

### Шаг 2: Настройте проект
1. Выберите проект в навигаторе
2. В разделе "Signing & Capabilities":
   - Снимите галочку "Automatically manage signing"
   - В поле "Team" выберите "None"
   - Очистите "Bundle Identifier" или оставьте как есть

### Шаг 3: Настройте Build Settings
1. Перейдите в Build Settings
2. Найдите "Code Signing Identity" и установите значение: `Don't Code Sign`
3. Найдите "Code Signing Required" и установите: `No`
4. Найдите "Code Signing Allowed" и установите: `No`

### Шаг 4: Соберите приложение
1. Выберите схему: Product → Scheme → SupportChat
2. Выберите устройство: Generic iOS Device
3. Соберите: Product → Build (⌘B)

### Шаг 5: Найдите .app файл
1. Product → Show Build Folder in Finder
2. Перейдите в Products/Release-iphoneos/
3. Найдите SupportChat.app

### Шаг 6: Создайте IPA
1. Создайте папку "Payload"
2. Скопируйте SupportChat.app в папку Payload
3. Сожмите папку Payload в ZIP
4. Переименуйте .zip в .ipa

## Способ 3: Через терминал (для опытных)

```bash
cd "ios app/SupportChat"

# Сборка без подписи
xcodebuild -project SupportChat.xcodeproj \
          -scheme SupportChat \
          -configuration Release \
          -sdk iphoneos \
          -arch arm64 \
          CODE_SIGN_IDENTITY="" \
          CODE_SIGNING_REQUIRED=NO \
          CODE_SIGNING_ALLOWED=NO

# Создание IPA
cd build/Release-iphoneos
mkdir Payload
cp -r SupportChat.app Payload/
zip -r SupportChat-TrollStore.ipa Payload
```

## Установка на iPhone через TrollStore

1. **Передайте IPA на iPhone:**
   - Через AirDrop
   - Через iCloud Drive/Google Drive/Dropbox
   - Через Files app
   - Через веб-сервер

2. **Установите через TrollStore:**
   - Откройте TrollStore
   - Нажмите "+" в правом верхнем углу
   - Выберите IPA файл
   - Нажмите "Install"

## Настройка подключения к серверу

После установки приложения нужно настроить подключение к вашему backend:

1. **Найдите IP адрес вашего компьютера:**
   - Windows: `ipconfig` (найдите IPv4 Address)
   - macOS: `ifconfig | grep "inet "`
   - Linux: `ip addr show`

2. **Запустите backend с доступом из сети:**
   ```bash
   # В корне проекта
   npm start
   ```

3. **В приложении:**
   - При первом запуске приложение попытается подключиться к localhost
   - Если нужно изменить адрес, это можно сделать в настройках (будет добавлено в следующих версиях)

## Возможные проблемы

### "Unsupported URL" при установке
- Убедитесь, что используете TrollStore, а не стандартный установщик iOS

### Приложение не подключается к серверу
- Проверьте, что телефон и компьютер в одной Wi-Fi сети
- Проверьте firewall на компьютере
- Попробуйте открыть http://YOUR_IP:3000 в Safari на телефоне

### Сборка не работает
- Убедитесь, что у вас последняя версия Xcode
- Проверьте, что выбран правильный SDK (iphoneos, не simulator)

## Дополнительные возможности TrollStore

- Приложение может использовать любые private API
- Нет ограничений на функциональность
- Приложение не будет отзывать сертификаты
- Можно устанавливать любое количество приложений

## Безопасность

⚠️ **Важно:** IPA файл без подписи может быть изменен кем угодно. Устанавливайте только те IPA, которые вы создали сами или получили из доверенных источников.
