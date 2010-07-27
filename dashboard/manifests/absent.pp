# Class: dashboard::absent
#
# Removes dashboard package
#
# Usage:
# include dashboard::absent
#
class dashboard::absent inherits dashboard {
    Package["dashboard"] {
        ensure => "absent" ,
    }
}
