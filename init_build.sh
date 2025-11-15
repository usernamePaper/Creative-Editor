#!/bin/bash

# Полный скрипт инициализации для сборки Minecraft Forge проекта 1.16.5

set -e

echo "Инициализация сборки Minecraft Forge 1.16.5..."

# Шаг 1: Запускаем задачи для подготовки к сборке
echo "Шаг 1: Подготовка к сборке (createMcpToSrg)..."
cd /workspaces/Creative-Editor
./gradlew createMcpToSrg --no-daemon 2>&1 | grep -v "^$" | tail -20

# Шаг 2: Запускаем compile java, чтобы создать маппированный JAR
echo "Шаг 2: Компиляция Java (создание маппированного JAR)..."
./gradlew compileJava --no-daemon 2>&1 | grep -E "JAR transformation complete|Writing|Failed" || true

# Шаг 3: Копируем маппированный JAR в bundeled_repo
echo "Шаг 3: Копирование маппированного JAR в bundeled_repo..."
mkdir -p "$HOME/.gradle/caches/forge_gradle/bundeled_repo/net/minecraftforge/forge/1.16.5-36.2.34_mapped_official_1.16.5"

SOURCE_JAR="$HOME/.gradle/caches/forge_gradle/minecraft_user_repo/net/minecraftforge/forge/1.16.5-36.2.34_mapped_official_1.16.5/forge-1.16.5-36.2.34_mapped_official_1.16.5.jar"
DEST_JAR="$HOME/.gradle/caches/forge_gradle/bundeled_repo/net/minecraftforge/forge/1.16.5-36.2.34_mapped_official_1.16.5/forge-1.16.5-36.2.34_mapped_official_1.16.5.jar"

if [ -f "$SOURCE_JAR" ]; then
    echo "Копируем JAR..."
    cp -v "$SOURCE_JAR" "$DEST_JAR"
    echo "JAR файл успешно скопирован"
else
    echo "ВНИМАНИЕ: Исходный JAR не найден"
    echo "Это может быть потому что compileJava не была выполнена успешно"
fi

# Шаг 4: Очищаем modules кэш
echo "Шаг 4: Очистка кэша модулей..."
rm -rf "$HOME/.gradle/caches/modules-2"

echo ""
echo "Инициализация завершена!"
echo "Теперь попробуйте запустить: ./gradlew build --no-daemon"
