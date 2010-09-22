# Class: exim::absent
#
# Removes exim package
#
# Usage:
# include exim::absent
#
class exim::absent inherits exim {
    Package["exim"] {
        ensure => "absent" ,
    }
}
