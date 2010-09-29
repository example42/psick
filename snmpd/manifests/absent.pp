# Class: snmpd::absent
#
# Removes snmpd package
#
# Usage:
# include snmpd::absent
#
class snmpd::absent inherits snmpd {
    Package["snmpd"] {
        ensure => "absent" ,
    }
}
