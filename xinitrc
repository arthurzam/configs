setxkbmap us,il -option grp:alt_shift_toggle
xrandr --output DP-1 --auto --right-of HDMI-1
xrandr --output eDP-1 --auto --right-of HDMI-1
numlockx &
exec dbus-launch --exit-with-session --sh-syntax i3
