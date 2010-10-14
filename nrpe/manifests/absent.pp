# Class: nrpe::absent
#
# Removes nrpe package
#
# Usage:
# include nrpe::absent
#
class nrpe::absent inherits nrpe {
    Package["nrpe"] {
        ensure => "absent" ,
    }
}
