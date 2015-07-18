#!/bin/bash

# shell scipt to prepend i3status with more stuff

i3status --config /home/arthur/.i3/i3status.conf | while :
do
    read line
    case "$(xset -q|grep LED|awk '{ print $10 }')" in
      "00000002") LG="English" ;;
      "00000000") LG="English" ;;
      "00000003") LG="English" ;;
      "00001002") LG="Hebrew" ;;
      "00001000") LG="Hebrew" ;;
      "00001003") LG="Hebrew" ;;
      *) LG="unknown" ;;
    esac
    BRIGHTNESS=`xbacklight`
    BRIGHTNESS=${BRIGHTNESS/.*}%
    dat="["
    dat+="{\"full_text\": \"$LG\"},"
    dat+="{\"full_text\": \"☀ $BRIGHTNESS\"},"
    echo "${line/[/$dat}" || exit 1
done
