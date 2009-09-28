class clamav {

}

class clamav::epel inherits clamav {

	package { clamav:
		name => $operatingsystem ? {
			default	=> "clamav",
			},
		ensure => present,
		require => File["/etc/yum.repos.d/epel.repo"],
	}

	package { clamav-data:
		name => $operatingsystem ? {
			default	=> "clamav-data",
			},
		ensure => present,
		require => File["/etc/yum.repos.d/epel.repo"],
	}

	package { clamav-update:
		name => $operatingsystem ? {
			default	=> "clamav-update",
			},
		ensure => present,
		require => File["/etc/yum.repos.d/epel.repo"],
	}

        file {
                "/etc/sysconfig/freshclam":
                        mode => 644, owner => root, group => root,
                        require => Package["clamav-update"],
                        ensure => present,
                        path => $operatingsystem ?{
                                default => "/etc/sysconfig/freshclam",
                        },
                        source => "puppet://$server/clamav/freshclam",
        }

        file {
                "/etc/freshclam.conf":
                        mode => 644, owner => root, group => root,
                        require => Package["clamav-update"],
                        ensure => present,
                        path => $operatingsystem ?{
                                default => "/etc/freshclam.conf",
                        },
                        source => "puppet://$server/clamav/freshclam.conf",
        }

        file {
                "/usr/local/bin/freshclam":
                        require => Package["clamav-update"],
                        ensure => "/usr/bin/freshclam",
        }

}
