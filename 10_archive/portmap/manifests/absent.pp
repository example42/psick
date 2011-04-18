# Class: portmap::absent
#
# Removes portmap package
#
# Usage:
# include portmap::absent
#
class portmap::absent inherits portmap {
    Package["portmap"] {
        ensure => "absent" ,
    }
}
