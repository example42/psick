# Class: clamav
#
# Manages clamav.
# Include it to install and run clamav with default settings
#
# Usage:
# include clamav


import "defines/*.pp"
import "classes/*.pp"

class clamav {

	include clamav::base

        case $operatingsystem {
                default: { }
        }

	if $backup == "yes" { include clamav::backup }
	if $monitor == "yes" { include clamav::monitor }
	if $firewall == "yes" { include clamav::firewall }

}
