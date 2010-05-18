# Class: apache::absent
#
# Removes apache package
#
# Usage:
# include apache::absent
#
class apache::absent inherits apache {
    Package["apache"] {
        ensure => "absent" ,
    }
}
