# openvpn-configscript
This script is intended to be used alongside wicd-gtk to disable ipv6 on certain devices (to prevent ipv6 leaks in lieu of OpenVPN usage), as well as help the user select an .ovpn file to use.

At this moment, it is very WIP and I'm basically just writing this at my own time and convenience while I learn how to bash.
I will be doing flow changes along the way, expect clunkiness while I slap this together.

At this moment, only the functions that enable or disable ipv6 are defined, with the openvpn configuration part coming along when my lazy butt gets in gear.
It is a very thin and dumb client, and essentially passes plaintext values to other commands. I may make it more feature-rich as time goes on.

It must be run with bash, not sh.
