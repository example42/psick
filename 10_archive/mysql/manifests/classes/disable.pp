# Class: mysql::disable
#
# Stops mysql service and disables it at boot time
#
# Usage:
# include mysql::disable
#
class mysql::disable inherits mysql {
    Service["mysql"] {
        ensure => "stopped" ,
        enable => "false",
    }
}
