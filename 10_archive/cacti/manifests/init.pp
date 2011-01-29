# Class: cacti
#
# Manages cacti.
# Include it to install and run cacti with default settings
#
# Usage:
# include cacti


import "defines/*.pp"
import "classes/*.pp"

class cacti {

    include cacti::base

    case $operatingsystem {
        debian: { include cacti::debian }
        ubuntu: { include cacti::debian }
        default: { }
    }

    if $backup == "yes" { include cacti::backup }
    if $monitor == "yes" { include cacti::monitor }
    if $firewall == "yes" { include cacti::firewall }

}
