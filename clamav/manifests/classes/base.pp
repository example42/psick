# Class: clamav::base
#
# Base clamav class. Installs package. To manage clamd service use also clamav::server
# This class is included by main clamav class, it's not necessary to call it directly

class clamav::base  {

	package { clamav:
		name   => $operatingsystem ? {
			default	=> "clamav",
			},
		ensure => present,
	}

	package { clamav-data:
		name   => $operatingsystem ? {
			default	=> "clamav-data",
			},
		ensure => present,
	}

	package { clamav-freshclam:
		name   => $operatingsystem ? {
			redhat 	=> "clamav-update",
			centos 	=> "clamav-update",
			default	=> "clamav-freshclam",
			},
		ensure => present,
	}

	package { clamav-daemon:
		name   => $operatingsystem ? {
			redhat 	=> "clamav-server",
			centos 	=> "clamav-server",
			default	=> "clamav-daemon",
			},
		ensure => present,
	}

}

