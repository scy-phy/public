#!/bin/bash
# set up your current machine as NAT between Internet on oNIC and network on iNIC
# Nils, SUTD, 2014
iNIC=eth2
#oNIC=wlan0
oNIC=wlan0
#iNIC=eth0:2

sudo iptables -A FORWARD -o $oNIC -i $iNIC -s 192.168.1.0/24 -m conntrack --ctstate NEW -j ACCEPT
sudo iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -t nat -F POSTROUTING
sudo iptables -t nat -A POSTROUTING -o $oNIC -j MASQUERADE

sudo sh -c "echo 1 > /proc/sys/net/ipv4/ip_forward"
