# Class: snmpd::disable
#
# Stops snmpd service and disables it at boot time
#
# Usage:
# include snmpd::disable
#
class snmpd::disable inherits snmpd {
    Service["snmpd"] {
        ensure => "stopped" ,
        enable => "false",
    }
}
