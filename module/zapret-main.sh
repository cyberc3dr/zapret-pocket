#!/system/bin/sh
MODPATH="/data/adb/modules/zapret"
UPDATEONSTART=$(cat "$MODPATH/config/update-on-start" 2>/dev/null || echo "1")
IPV6ENABLE=$(cat "$MODPATH/config/ipv6-enable" 2>/dev/null || echo "0")
mkdir -p "$MODPATH/config" "$MODPATH/list" "$MODPATH/ipset"

migrate_legacy_link() {
    legacy="$MODPATH/config/$1"
    current="$MODPATH/config/$2"
    if [ -f "$legacy" ]; then
        if [ ! -f "$current" ]; then
            mv "$legacy" "$current"
        else
            rm -f "$legacy"
        fi
    fi
}

migrate_legacy_link custom-ipv4-ranges-url ipset-v4-link
migrate_legacy_link custom-ipv6-ranges-url ipset-v6-link
migrate_legacy_link custom-rkn-registry-url reestr-link
touch "$MODPATH/ipset/custom.txt"
touch "$MODPATH/ipset/exclude.txt"
touch "$MODPATH/ipset/ipset-v4.txt"
touch "$MODPATH/ipset/ipset-v6.txt"
touch "$MODPATH/list/custom.txt"
touch "$MODPATH/list/default.txt"
touch "$MODPATH/list/exclude.txt"
touch "$MODPATH/list/google.txt"
touch "$MODPATH/list/reestr.txt"
if [ "$UPDATEONSTART" = "1" ]; then
    . "$MODPATH/update.sh" > /dev/null 2>&1
    sleep 2
fi
nohup sh "$MODPATH/zapret/zapret.sh" > /dev/null 2>&1 &

