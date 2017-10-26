setxkbmap us,il -option grp:alt_shift_toggle
#xrandr --output DP1 --auto --right-of HDMI1
#xrandr --output DP2 --auto --right-of HDMI1
xrandr --output HDMI1 --auto --right-of HDMI2
numlockx &
exec dbus-launch --exit-with-session --sh-syntax i3
