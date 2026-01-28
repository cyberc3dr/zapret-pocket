MODPATH="/data/adb/modules/zapret"
echo "! Please wait, this action takes some time"
if pgrep -f "nfqws" >/dev/null 2>&1; then
    echo "! STOPPING SERVICE..."
    sh "$MODPATH/uninstall.sh" > /dev/null 2>&1
    echo "- Service stopped"
    sleep 2
else
    echo "! STARTING SERVICE..."
    sh "$MODPATH/service.sh" > /dev/null 2>&1
    echo "- Service started"
    sleep 3
fi
