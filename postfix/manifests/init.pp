# Class: postfix
#
# Manages postfix.
# Include it to install and run postfix with default settings
#
# Usage:
# include postfix


import "defines/*.pp"
import "classes/*.pp"

class postfix {

	require sendmail::disable
	include postfix::base

        case $operatingsystem {
                default: { }
        }

	if $backup == "yes" { include postfix::backup }
	if $monitor == "yes" { include postfix::monitor }
	if $firewall == "yes" { include postfix::firewall }

}
