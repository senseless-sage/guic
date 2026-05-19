#!/bin/sh

dbus-daemon --session --address="$DBUS_SESSION_BUS_ADDRESS" --fork --nopidfile
gnome-keyring-daemon --daemonize --components=secrets
/usr/libexec/xdg-desktop-portal &

exec /usr/bin/catatonit -P
