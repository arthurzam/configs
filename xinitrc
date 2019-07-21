setxkbmap us,il -option grp:alt_shift_toggle
xrandr --output HDMI1 --auto --right-of HDMI2
numlockx &

systemctl --user import-environment DISPLAY
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$(id -u)/bus
exec /usr/bin/i3
