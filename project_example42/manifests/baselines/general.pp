class general {

# This general class imports all minimal settings.
# You may decide to define different "general" classes and define here site-wide logic
        include minimal

# Iptables settings.
# Some example alternatives
#       include iptables
        include iptables::disable
#       include iptables::enable


# Sysctl management. Define "$my_ipforward = yes" for activating IP forwarding
        include sysctl

# Various packages/settings you may want on a general host
# TO DO: Complete and standardize modules
#       include nrpe
#       include snmpd
       include ntp
#       include clock
#       include cron

# Syslog Management
# Needs:  $syslog_server
       include syslog 

       include rootmail
#       include func
#       include aide
#       include psad
#       include rsync
#       include logrotate

}

