#!/bin/bash
FILE=/run/user/$UID/i3/dual-monitor
SCREEN=VGA1
vga_on() {
  if  (xrandr | grep -e "$SCREEN connected" > /dev/null); then
    echo 1 > $FILE
    xrandr --output $SCREEN --auto --right-of LVDS1
  fi
}

vga_off() {
  echo 0 > $FILE
  xrandr --output $SCREEN --off
}
if [ ! -f $FILE ]; then
    vga_on
else
    [ $(cat $FILE) == 1 ] && vga_off || vga_on
fi
