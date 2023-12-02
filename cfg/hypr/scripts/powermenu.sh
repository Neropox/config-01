#!/bin/bash

# Menu variables
shutdown='󰐥 Shutdown'
reboot='󰜉 Reboot'
lock=' Lock'
suspend='󰤄 Sleep'
logout='󰗼 Logout'


# switch case break dat bitch!!
chosen=$(echo -e "$lock\n$suspend\n$logout\n$reboot\n$shutdown" | rofi -dmenu -p "Питание" -theme ~/.config/rofi/powermenu.rasi)
case ${chosen} in
    $shutdown)
		systemctl poweroff
        ;;
    $reboot)
		systemctl reboot
        ;;
    $lock)
		gtklock
        ;;
    $suspend)
		systemctl suspend && gtklock 
        ;;
    $logout)
		hyprctl dispatch exit 0
        ;;
esac
