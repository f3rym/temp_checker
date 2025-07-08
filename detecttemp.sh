#!/bin/bash
if ! type sensors >/dev/null 2>&1; then
    echo "Утилита не найдена, устанавливаю..."
    dist=$(awk -F= '/^ID=/{gsub(/"/, "", $2); print $2}' /etc/os-release)
    if [[ $dist == "ubuntu" || $dist == "debian" ]]; then
        sudo apt-get update && sudo apt-get install -y lm-sensors
    elif [[ $dist == "arch" ]]; then
        sudo pacman -Sy lm_sensors
    elif [[ $dist == "fedora" ]]; then
        sudo dnf install -y lm_sensors
    else
        echo "❌ Неизвестный дистрибутив: $dist. Установите lm-sensors вручную."
        exit 1
    fi
fi

while true; do
    read num1 num2 <<< "$(sensors | grep '+.*C' | awk '{print $2}' | tr -d '+°C' | head -n2 | xargs)"
    if [[ -n "$num1" && -n "$num2" ]]; then
        if (( $(echo "$num2 > 75" | bc -l) )) || (( $(echo "$num1 > 65" | bc -l) )); then
            echo -e "\e[5m\e[31m🔥 CPUs HOT! AAAAAAAAAAAAA 🔥\e[0m"
        elif (( $(echo "$num2 > 60" | bc -l) )) || (( $(echo "$num1 > 55" | bc -l) )); then
            echo -e "\e[33m⚠ CPUs getting warm...\e[0m"
        fi
    else
        echo -e "\e[31m⚠ Не удалось считать температуры.\e[0m"
    fi

    sleep 30
done

sleep 5
done
