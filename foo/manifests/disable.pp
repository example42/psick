# Class: foo::disable
#
# Stops foo service and disables it at boot time
#
# Usage:
# include foo::disable
#
class foo::disable inherits foo {
    Service["foo"] {
        ensure => "stopped" ,
        enable => "false",
    }
}
