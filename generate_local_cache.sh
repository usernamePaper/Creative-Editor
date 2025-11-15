#!/bin/bash

# Генерируем необходимые файлы в локальном кэше gradle для Forge 1.16.5

CACHE_DIR="$HOME/.gradle/caches/forge_gradle/bundeled_repo/net/minecraftforge/forge/1.16.5-36.2.34_mapped_official_1.16.5"
SOURCE_DIR="$HOME/.gradle/caches/forge_gradle/minecraft_user_repo/net/minecraftforge/forge/1.16.5-36.2.34_mapped_official_1.16.5"

mkdir -p "$CACHE_DIR"

if [ -d "$SOURCE_DIR" ]; then
    echo "Copying from $SOURCE_DIR to $CACHE_DIR"
    cp -v "$SOURCE_DIR"/* "$CACHE_DIR/" 2>/dev/null || true
    echo "Done copying files"
else
    echo "Source directory not found: $SOURCE_DIR"
    exit 1
fi

# Проверяем, есть ли файлы
if [ -f "$CACHE_DIR/forge-1.16.5-36.2.34_mapped_official_1.16.5.jar" ]; then
    echo "Success: JAR file is in place"
else
    echo "Error: JAR file not found"
    exit 1
fi
