# Class: nagios::absent
#
# Removes nagios package
#
# Usage:
# include nagios::absent
#
class nagios::absent inherits nagios {
    Package["nagios"] {
        ensure => "absent" ,
    }
}
