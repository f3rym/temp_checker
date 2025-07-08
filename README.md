# 🌡️ detecttemp.sh — CPU Temperature Monitor

## 🚀 Описание

`detecttemp.sh` — это простой Bash-скрипт для **мониторинга температуры CPU** в Linux.  
Он:
- проверяет наличие утилиты `lm-sensors`, и если её нет — устанавливает в зависимости от дистрибутива,
- каждые **30 секунд** считывает температуру двух первых ядер,
- выводит цветные предупреждения, если температура превышает заданные пороги.

🔥 Репозиторий: [https://github.com/f3rym/temp_checker.git](https://github.com/f3rym/temp_checker.git)

---

## ✅ Поддерживаемые дистрибутивы

Скрипт автоматически определяет и ставит `lm-sensors` на:
- **Ubuntu / Debian** (`apt-get`)
- **Arch Linux** (`pacman`)
- **Fedora** (`dnf`)

Если дистрибутив не распознан, скрипт напишет, что нужно установить `lm-sensors` вручную.

---

## 🛠 Требования

- `bash`
- `awk`, `grep`, `tr`, `head`, `xargs`
- `bc` (для работы с числами с плавающей точкой)
- `lm-sensors`

Все утилиты (кроме `lm-sensors`) обычно уже предустановлены в Linux.

---

## 📥 Установка

1. Клонируйте репозиторий:
    ```bash
    git clone https://github.com/f3rym/temp_checker.git
    cd temp_checker
    ```

2. Дайте права на выполнение скрипту:
    ```bash
    chmod +x detecttemp.sh
    ```

---

## 🚀 Запуск

Просто запустите скрипт в терминале:

```bash
./detecttemp.sh
```
Он будет каждые 30 секунд выводить температуру и сигнализировать о перегреве.

## ⚙️ Автозагрузка через systemd
Если хотите, чтобы скрипт запускался автоматически при старте системы:

Создайте сервис-файл:
```bash
sudo nano /etc/systemd/system/detecttemp.service
Вставьте туда:
```

```
[Unit]
Description=CPU Temperature Monitor (detecttemp.sh)
After=network.target

[Service]
ExecStart=/full/path/to/temp_checker/detecttemp.sh
Restart=always
User=your_username

[Install]
WantedBy=default.target
```
Замените:
`/full/path/to/temp_checker/detecttemp.sh` на абсолютный путь к скрипту,
your_username на имя вашего пользователя.

Обновите systemd и включите автозапуск:
```bash
sudo systemctl daemon-reload
sudo systemctl enable detecttemp
sudo systemctl start detecttemp
```
### Проверить статус:

`systemctl status detecttemp`
🔥 Пример вывода
```
⚠ CPUs getting warm...
🔥 CPUs HOT! AAAAAAAAAAAAA 🔥
```
Используются цвета и мигание, чтобы выделить предупреждения в терминале.
