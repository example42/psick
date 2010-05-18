# Class: cacti::absent
#
# Removes cacti package
#
# Usage:
# include cacti::absent
#
class cacti::absent inherits cacti::base {
    Package["cacti"] {
        ensure => "absent" ,
    }
}
