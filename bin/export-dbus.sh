#!/bin/bash
# Exportiere die dbus session address, damit sie via Cron nutzbar ist
# Diese Datei muss via Autostart ausgeführt werden

touch $HOME/.Xdbus
chmod 600 $HOME/.Xdbus
env | grep DBUS_SESSION_BUS_ADDRESS > $HOME/.Xdbus
echo 'export DBUS_SESSION_BUS_ADDRESS' >> $HOME/.Xdbus
