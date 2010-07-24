# Class: puppet::absent
#
# Removes puppet package
#
# Usage:
# include puppet::absent
#
class puppet::absent inherits puppet {
    Package["puppet"] {
        ensure => "absent" ,
    }
}
