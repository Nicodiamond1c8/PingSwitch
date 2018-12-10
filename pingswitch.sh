#!/bin/bash
#Simple ping-reply switch - Beasty
#Getopts by 3lpsey

set -e;

HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="Ping-Switch"
TITLE="Ping-Switch"
MENU="Choose one of the following options:"

OPTIONS=(1 "Ping-reply OFF"
         2 "Ping-reply ON"
     3 "Ping-reply OFF - Persistent"
     4 "Ping-reply ON - Persistent")

CHOICE=""
NON_INT=0

function print_usage() {
      echo "here is how you do everthing"
}

while getopts "c:nh" opt; do
  case ${opt} in
    c ) CHOICE="$OPTARG"
      ;;
    n ) NON_INT=1
      ;;
    h) print_usage && exit 0
      ;;
  esac
done

if [[ ${#CHOICE} -lt 1 && $NON_INT == 1 ]]; then
    echo "You need to pass the option 1,2,3,4 for non-interactive"
    exit 1
fi
if [[ ${#CHOICE} -lt 1 ]]; then
    DIALOG_BIN=$(which dialog)
    if [[ ${#DIALOG_BIN} -lt 1 ]]; then
        echo "Please install dialog or use non-interactive mode"
        exit 1
    fi
    CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)
    clear
fi

case $CHOICE in
        1)
        echo "Turning ping reply off"
            echo "1" > /proc/sys/net/ipv4/icmp_echo_ignore_all
            ;;
        2)
        echo "Turning ping replay on"
            echo "0" > /proc/sys/net/ipv4/icmp_echo_ignore_all
            ;;
        3)
        echo "Doing something"
        echo "net.ipv4.icmp_echo_ignore_all ..." >> /etc/sysctl.conf
        ;;
        4)
        echo "Doing something"
        sed -i '/echo_ignore_all/d' /etc/sysctl.conf
            ;;
esac
