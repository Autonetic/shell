#!/bin/bash
function my_ip() {
        STRING=echo ip a | grep "inet 192.168" | awk '{$1=$1};1' | sed 's/\(inet\s*\|brd 192.168.1.255 scope global dynamic noprefixroute wlan0\s*\|<END>\)//g'
        echo "$STRING"
}
my_ip
