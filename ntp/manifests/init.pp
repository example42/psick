class ntp {

	package { ntp:
		name => $operatingsystem ? {
			default	=> "ntp",
			},
		ensure => present,
	}

	service { ntpd:
		name => $operatingsystem ? {
                        default => "ntpd",
                        },
		ensure => running,
		enable => true,
		hasrestart => true,
		hasstatus => true,
		require => Package[ntp],
		subscribe => File["ntp.conf"],
	}

	file {	
             	"ntp.conf":
			mode => 644, owner => root, group => root,
			require => Package[ntp],
			ensure => present,
			path => $operatingsystem ?{
                        	default => "/etc/ntp.conf",
                        },
	}
	
	file {	
             	"/etc/ntp/keys":
			mode => 600, owner => root, group => root,
			require => Package[ntp],
			ensure => present,
			path => $operatingsystem ?{
                        	default => "/etc/ntp/keys",
                        },
	}

}

class ntpdate {

	package { ntp:
		name => $operatingsystem ? {
			default	=> "ntp",
			},
		ensure => present,
	}

	file {	
             	"/etc/cron.hourly/ntpdate":
			mode => 755, owner => root, group => root,
			require => Package[ntp],
	                content => template("ntp/ntpdate"),
	}
	
}
