#!/bin/bash
#Simple ping-reply switch by RDSploit
HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="RDSploit Ping-Switch"
TITLE="Ping-Switch"
MENU="Choose one of the following options:"

OPTIONS=(1 "Ping-reply OFF"
         2 "Ping-reply ON"
	 3 "Ping-reply OFF - Persistent"
	 4 "Ping-reply ON - Persistent")
CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            echo "1" > /proc/sys/net/ipv4/icmp_echo_ignore_all
            ;;
        2)
            echo "0" > /proc/sys/net/ipv4/icmp_echo_ignore_all
            ;;
        3)
	    echo "net.ipv4.icmp_echo_ignore_all ..." >> /etc/sysctl.conf
	    ;;
        4)
	    sed -i '/echo_ignore_all/d' /etc/sysctl.conf
            ;;
esac

