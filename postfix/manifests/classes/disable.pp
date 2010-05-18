# Class: postfix::disable
#
# Stops postfix service and disables it at boot time
#
# Usage:
# include postfix::disable
#
class postfix::disable inherits postfix {
    Service["postfix"] {
        ensure => "stopped" ,
        enable => "false",
    }
}
