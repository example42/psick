# Class: autofs::absent
#
# Removes autofs package
#
# Usage:
# include autofs::absent
#
class autofs::absent inherits autofs {
    Package["autofs"] {
        ensure => "absent" ,
    }
}
