# Class: dovecot
#
# Manages dovecot.
# Include it to install and run dovecot with default settings
#
# Usage:
# include dovecot


import "defines/*.pp"
import "classes/*.pp"

class dovecot {

	include dovecot::base

        case $operatingsystem {
                default: { }
        }

	if $backup == "yes" { include dovecot::backup }
	if $monitor == "yes" { include dovecot::monitor }
	if $firewall == "yes" { include dovecot::firewall }

}
