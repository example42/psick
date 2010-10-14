# Class: mcollective::absent
#
# Removes mcollective package
#
# Usage:
# include mcollective::absent
#
class mcollective::absent inherits mcollective {
    Package["mcollective"] {
        ensure => "absent" ,
    }
}
