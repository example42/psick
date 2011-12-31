# Class: mailscanner
#
# Manages mailscanner.
# Include it to install and run mailscanner with default settings
#
# Usage:
# include mailscanner
#

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
        centos: { include mailscanner::netinstall  include mailscanner::redhat }
        redhat: { include mailscanner::netinstall  include mailscanner::redhat }
        default: { include mailscanner::netinstall }
    }

    file {
        "MailScanner.conf":
        require => $operatingsystem ? {
            ubuntu  => Package["mailscanner"],
            debian  => Package["mailscanner"],
            default => Exec["MailScannerBuildAndInstall"],
            },
        ensure => present,
        path   => "/etc/MailScanner/MailScanner.conf",
        notify => Service["mailscanner"],
    }

    service { mailscanner:
        name => $operatingsystem ? {
            debian  => "mailscanner",
            ubuntu  => "mailscanner",
            default => "MailScanner",
            },
        ensure => running,
        enable => true,
        hasrestart => true,
        hasstatus => true,
        require => $operatingsystem ? {
            ubuntu  => Package["mailscanner"],
            debian  => Package["mailscanner"],
            default => Exec["MailScannerBuildAndInstall"],
            },
    }

#    if $backup == "yes" { include mailscanner::backup }
#    if $monitor == "yes" { include mailscanner::monitor }
#    if $firewall == "yes" { include mailscanner::firewall }

}
