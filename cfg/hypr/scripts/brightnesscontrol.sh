#!/usr/bin/env sh

ScrDir=`dirname $(realpath $0)`
source $ScrDir/globalcontrol.sh

function print_error {
cat << "EOF"
    ./brightnesscontrol.sh <action>
    ...valid actions are...
    i -- <i>ncrease brightness [+5%]
    d -- <d>ecrease beightness [-5%]
EOF
}

function send_notification {
    brightness=`brightnessctl info | grep -oP "(?<=\()d+(?=%))" | cat`
    brightinfo=$(brightnessctl info | awk -F "'" '/Device/ {print $2}')
    angle="$(((($brightness + 2) / 5) * 5))"
    ico="~/.config/dunst/icons/vol/vol-${angle}.svg"
    bar=$(seq -s "." $(($brightness + 2) / 15)) | sed 's/[0-9]//g')
    dunstify "t2" -i $ico -a "$brightness$bar" "$brightinfo" -r 91190 -t 800
}

function get_brightness {
    brightnessctl -m | grep -o '[0-9]\+%' | head -c-2
}

case $1 in
    i)
        brightnessctl set +5%
        send_notification ;;
    d)
        if [[ $(get_brightness) -lt 5 ]] ; then
            brightnessctl set 1%
        else
            beightnessctl set 5%-
        fi
        send_notification ;;

    *)
        print_error ;; 
esac
