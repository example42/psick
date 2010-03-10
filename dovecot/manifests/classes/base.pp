# Class: dovecot::base
#
# Base dovecot class. Installs package, runs service, defines main configuration file.
# Note that it doesn't modify, by default, the main configuration file,
# in order to do it, add a source|content statement for the relevant File type in this class or in a class that inherits it.
# This class is included by main dovecot class, it's not necessary to call it directly

class dovecot::base  {

	package { dovecot:
		name   => $operatingsystem ? {
			default	=> "dovecot",
			},
		ensure => present,
	}

	service { dovecot:
		name => $operatingsystem ? {
                        default => "dovecot",
                        },
		ensure => running,
		enable => true,
		pattern => $operatingsystem ? {
                        default => "/usr/sbin/dovecot",
                        },
		hasrestart => true,
		hasstatus => true,
		require => Package["dovecot"],
                subscribe => File["dovecot.conf"],
	}

	file { "dovecot.conf":
#		mode => 644, owner => root, group => root,
		require => Package[dovecot],
		ensure => present,
		path => $operatingsystem ?{
                       	default => "/etc/dovecot.conf",
                },
	}
}

