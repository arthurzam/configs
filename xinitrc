setxkbmap us,il -option grp:alt_shift_toggle
xrandr --output DP1 --auto --right-of HDMI1
xrandr --output eDP1 --auto --right-of HDMI1
numlockx &
exec dbus-launch --exit-with-session --sh-syntax i3
