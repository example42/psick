#!/bin/sh

# File Managed by Puppet

iptables -I INPUT -s $1 -j ACCEPT

echo "RIP Access `date +%Y%m%d-%T` IP: $1 " >> /var/log/rip.log
echo "--------------------------------------------------------------------------------"  >> /var/log/rip.log
echo "RIP Access `date +%Y%m%d-%T` IP: $1 `whois_psad $1` " | mail -s "RIP Access from $1" <%= root_email %>

