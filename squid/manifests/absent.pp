# Class: squid::absent
#
# Removes squid package
#
# Usage:
# include squid::absent
#
class squid::absent inherits squid {
    Package["squid"] {
        ensure => "absent" ,
    }
}
