MODPATH="/data/adb/modules/zapret"
echo "! Please wait, this action takes some time"
mkdir -p "$MODPATH/config"
if pgrep -f "nfqws" >/dev/null 2>&1; then
    echo "! STOPPING SERVICE..."
    sh "$MODPATH/uninstall.sh" > /dev/null 2>&1
    echo "1" > "$MODPATH/config/status"
    echo "- Service stopped"
    sh "$MODPATH/update-description.sh" > /dev/null 2>&1
    sleep 2
else
    echo "! STARTING SERVICE..."
    sh "$MODPATH/service.sh" > /dev/null 2>&1
    echo "0" > "$MODPATH/config/status"
    echo "- Service started"
    sh "$MODPATH/update-description.sh" > /dev/null 2>&1
    sleep 3
fi
