# Class: clamav::absent
#
# Removes clamav package
#
# Usage:
# include clamav::absent
#
class clamav::absent inherits clamav {
    Package["clamav"] {
        ensure => "absent" ,
    }
}
