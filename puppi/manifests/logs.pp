#
# Class puppi::logs
# Creates default system-wide logs locations for diffent OSes to be used by the puppi log command
#
class puppi::logs {

    case $operatingsystem {
        Debian,Ubuntu: { 
            puppi::log { "messages": hostwide => "yes" , logpath => "/var/log/messages" }
            puppi::log { "syslog": hostwide => "yes" , logpath => "/var/log/syslog" }
        }
        RedHat,CentOS: { 
            puppi::log { "messages": hostwide => "yes" , logpath => "/var/log/messages" }
        }
        default: { }
    }

}

