# Class: mailscanner
#
# Manages mailscanner.
# Include it to install and run mailscanner with default settings
#
# Usage:
# include mailscanner


import "defines/*.pp"
import "classes/*.pp"

class mailscanner {

# Define here how you install Mailscanner
# Use mailscanner::netinstall to download, build and install the packages
# If you don't want to build the packages directly on the mailscanner host and can provide them via the Package type
# use mailscanner::package 


        case $operatingsystem {
                debian: { include mailscanner::package }
                ubuntu: { include mailscanner::package }
                default: { include mailscanner::netinstall }
        }

	include mailscanner::base

	if $backup == "yes" { include mailscanner::backup }
	if $monitor == "yes" { include mailscanner::monitor }
	if $firewall == "yes" { include mailscanner::firewall }

}
