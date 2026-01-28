#!/system/bin/sh
MODPATH="/data/adb/modules/zapret"

# Создаем директорию конфига если ее нет
mkdir -p "$MODPATH/config"

# Читаем текущий статус (0 = работает, 1 = выключено)
STATUS=$(cat "$MODPATH/config/status" 2>/dev/null || echo "1")

# Определяем иконку статуса
if [ "$STATUS" = "0" ]; then
    STATUS_TEXT="✅ working"
else
    STATUS_TEXT="⛔ not working"
fi

# Обновляем description в module.prop
if [ -f "$MODPATH/module.prop" ]; then
    # Сохраняем все строки кроме description
    grep -v "^description=" "$MODPATH/module.prop" > "$MODPATH/module.prop.tmp"
    
    # Добавляем обновленное description
    echo "description=⚡ DPI bypass on Android with additional features | Status: $STATUS_TEXT" >> "$MODPATH/module.prop.tmp"
    
    # Заменяем оригинальный файл
    mv "$MODPATH/module.prop.tmp" "$MODPATH/module.prop"
fi
