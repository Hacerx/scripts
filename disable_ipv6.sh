#!/bin/bash
echo "Editando configuración..."
echo "#Disable ipv6" >> /etc/sysctl.conf
echo "net.ipv6.conf.all.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.default.disable_ipv6 = 1" >> /etc/sysctl.conf
echo "net.ipv6.conf.lo.disable_ipv6 = 1">> /etc/sysctl.conf
echo "Actualizando configuración..."
sudo sysctl -p
echo "Si aparece un 1, todo correcto :)"
cat /proc/sys/net/ipv6/conf/all/disable_ipv6
