# Class: postfix::base
#
# Base postfix class. Installs package, runs service, defines main configuration file.
# Note that it doesn't modify, by default, the main configuration file,
# in order to do it, add a source|content statement for the relevant File type in this class or in a class that inherits it.
# This class is included by main postfix class, it's not necessary to call it directly

class postfix::base  {

	package { postfix:
		name   => $operatingsystem ? {
			default	=> "postfix",
			},
		ensure => present,
	}

	service { postfix:
		name => $operatingsystem ? {
                        default => "postfix",
                        },
		ensure => running,
		enable => true,
		pattern => $operatingsystem ? {
                        default => "/usr/sbin/postfix",
                        },
		hasrestart => true,
		hasstatus => true,
		require => Package["postfix"],
                subscribe => File["main.cf"],
	}

	file { "main.cf":
#		mode => 644, owner => root, group => root,
		require => Package[postfix],
		ensure => present,
		path => $operatingsystem ?{
                       	default => "/etc/postfix/main.cf",
                },
	}
}

