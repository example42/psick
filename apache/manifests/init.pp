# Class: apache
#
# Manages apache.
# Include it to install and run apache with default settings
#
# Usage:
# include apache


import "defines/*.pp"
import "classes/*.pp"

class apache {

	include apache::base

        case $operatingsystem {
                debian: { include apache::debian }
                ubuntu: { include apache::debian }
                default: { }
        }

	if $backup { include apache::backup }
	if $monitor { include apache::monitor }
	if $firewall { include apache::firewall }

}
