#!/bin/bash

## BOY HOWDY!
## These are the commands that this script focuses on making ease of:
##
## starting tunnel sessions and such:
## (sudo) openvpn file.openvpn
## and hopefully some others
##
## ------This will disable IPv6 to <interface-name>:
## (sudo) echo 1 > /proc/sys/net/ipv6/conf/<interface-name>/disable_ipv6
##
## ------The inverse will enable TPv6 to <interface-name>
## (sudo) echo 0 > /proc/sys/net/ipv6/conf/<interface-name>/disable_ipv6
##

clear
echo
echo "Hello, this is the OpenVPN pseudo-suite."
echo
echo You may have to sudo some commands, but they will be read out in parenthesis.
echo && sleep 0.5
echo -------- Always read a script before you execute it! --------
echo

#This is where we define our menu-functions before we call for them:

#This one will enable ipv6 (which has vpn leaks):
ENABLEIPV6QUERY ()
{
    clear
    echo You may have to sudo to list devices \(\$ifconfig -s\)  && sleep 1
    echo
    echo Current list of devices:
    echo ---------------------------------------------------
    sudo ifconfig -s #this will probably cause a sudo password query to print in a line, a feature-bug
    echo ---------------------------------------------------
    echo && sleep 0.5
    echo "Please enter which device you would like to enable IPv6 on: "
    echo
    echo "*** You may enter '!menu' to go back to the main dialog, or !ifconfig for a more verbose list."
    echo
    read -p "iface name: " I6IFUP ## ("IPv6 interface up") this is the name that will go in the IPV6 disable command
    sleep 0.5
    if [ $I6IFUP == "!ifconfig" ];
    then
        sudo ifconfig -a | less
        ENABLEIPV6QUERY
    fi
    if [ $I6IFUP == "!menu" ];
    then
        sleep 0.5
        clear
        THREEWAY
    fi
    echo
    echo "Is this the interface you wish to enable IPv6 on?: "
    echo "|"
    echo "|"
    echo ">"
    sudo ifconfig  $I6IFUP
    sleep 0.5
    echo
    echo "(if the above output is an error, you probably typo'd an interface name)"
    echo "(if it's a bunch of network device stats, you did good kid)"
    echo
    read -p "Enable IPv6 on this device?: [y/n] " -n 1 I6UPAFFIRM
    if [ $I6UPAFFIRM == "y" ];
    then
        echo 0 | sudo tee /proc/sys/net/ipv6/conf/$I6IFUP/disable_ipv6 > /dev/null ##pointing it to /dev/null keeps it from returning the ECHO to console
        echo
        echo "If the next output returns 0, the interface has IPv6 enabled:" ## I will probably make this part less clunky with an if statement, like 'if 0 then echo "it worked!"
        sleep 0.5
        cat /proc/sys/net/ipv6/conf/$I6IFUP/disable_ipv6
        echo
        sleep 0.5
        read -p "Hit any key to return to the main dialog." -n 1 GETOUTOFDODGE
        if [ $GETOUTOFDODGE != "AVALUEMORETHANONECHAR" ]; ## Basically, it will only read up to one character, but exclude anything that is anything that isn't this arbitrary value. I probably could have done this with an "if true" statement
        then
            sleep 0.5
            clear
            THREEWAY
        fi
    else
        ENABLEIPV6QUERY
    fi
}

##This one is like (as in "total copy") the above function, but it disables instead:

DISABLEIPV6QUERY ()
{
    clear
    echo You may have to sudo to list devices \(\$ifconfig -s\)  && sleep 1
    echo
    echo Current list of devices:
    echo ---------------------------------------------------
    sudo ifconfig -s #this will probably cause a sudo password query to print in a line, a feature-bug
    echo ---------------------------------------------------
    echo && sleep 0.5
    echo "Please enter which device you would like to disable IPv6 on: "
    echo
    echo "*** You may enter '!menu' to go back to the main dialog, or !ifconfig for a more verbose list."
    echo
    read -p "iface name: " I6IFDOWN ## ("IPv6 interface up") this is the name that will go in the IPV6 disable command
    sleep 0.5
    if [ $I6IFDOWN == "!ifconfig" ];
    then
        sudo ifconfig -a | less
        DISABLEIPV6QUERY
    fi
    if [ $I6IFDOWN == "!menu" ];
    then
        sleep 0.5
        clear
        THREEWAY
    fi
    echo
    echo "Is this the interface you wish to disable IPv6 on?: "
    echo "|"
    echo "|"
    echo ">"
    sudo ifconfig  $I6IFDOWN
    sleep 0.5
    echo
    echo "(if the above output is an error, you probably typo'd an interface name)"
    echo "(if it's a bunch of network device stats, you did good kid)"
    echo
    read -p "Enable IPv6 on this device?: [y/n] " -n 1 I6DOWNAFFIRM
    if [ $I6DOWNAFFIRM == "y" ];
    then
        echo 1 | sudo tee /proc/sys/net/ipv6/conf/$I6IFDOWN/disable_ipv6 > /dev/null ##pointing it to /dev/null keeps it from returning the ECHO to console
        echo
        echo "If the next output returns 1, the interface has IPv6 disabled:" ## I will probably make this part less clunky with an if statement, like 'if 0 then echo "it worked!"
        sleep 0.5
        cat /proc/sys/net/ipv6/conf/$I6IFDOWN/disable_ipv6
        echo
        sleep 0.5
        read -p "Hit any key to return to the main dialog." -n 1 GETOUTOFDODGE0
        if [ $GETOUTOFDODGE0 != "AVALUEMORETHANONECHAR" ]; ## I know that I probably don't need to change these variable names across independent functions, but I'm going to be superstitious anyways. 
        then
            sleep 0.5
            clear
            THREEWAY
        fi
    else
        ENABLEIPV6QUERY
    fi
}


#This one asks the user if they would rather config OpenVPN, Enable IPV6, or Disable IPV6 ( is otherwise known as a "main menu")
THREEWAY ()
{
    echo "Which would you like to do?:" && sleep 0.5
    echo "|"
    echo "|"
    echo "> Options:"
    echo "------ o - for OpenVPN Config"
    echo "------ e - enable IPV6 on device"
    echo "------ d - disable IPV6 on device"
    echo
    read -p "Use your fingers with the keyboard. <[o/e/d]>:  " -s -n 1 -r MENUBRO
    if [ $MENUBRO == "o" ];
    then
        OPENVPNMENU ##STILL HAVE TO IMPLEMENT THIS !!!!!!!!!!!!!!
    fi
    if [ $MENUBRO == "e" ];
    then
        ENABLEIPV6QUERY
    fi
    if [ $MENUBRO == "d" ];
    then
        DISABLEIPV6QUERY
    fi
}

while true; do
    THREEWAY
done

