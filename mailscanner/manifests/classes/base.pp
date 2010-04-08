# Class: mailscanner::base
#
# Base mailscanner class. Runs service, defines main configuration file. Requires the installation via package or netinstall
# Note that it doesn't modify, by default, the main configuration file,
# in order to do it, add a source|content statement for the relevant File type in this class or in a class that inherits it.
# This class is included by main mailscanner class, it's not necessary to call it directly

class mailscanner::base  {

        file {
                "MailScanner.conf":
#                mode => 644, owner => root, group => root,
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

}
