# Class: dovecot::disable
#
# Stops dovecot service and disables it at boot time
#
# Usage:
# include dovecot::disable
#
class dovecot::disable inherits dovecot {
    Service["dovecot"] {
        ensure => "stopped" ,
        enable => "false",
    }
}
