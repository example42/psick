class dovecot {
	package { dovecot:
		name => $operatingsystem ? {
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
		hasrestart => true,
		hasstatus => true,
		require => Package["dovecot"],
		subscribe => File["dovecot.conf"],
	}

	file {	
             	"dovecot.conf":
		mode => 644, owner => root, group => root,
		require => Package["dovecot"],
		ensure => present,
		path => $operatingsystem ?{
                       	default => "/etc/dovecot.conf",
                	},
	}
	
}

class dovecot::mysql inherits dovecot {

        File["dovecot.conf"] {
                        source => "puppet://$servername/dovecot/dovecot.conf-mysql"
        }

        file {
                "dovecot-mysql.conf":
                        mode => 644, owner => root, group => root,
                        require => File["dovecot.conf"],
                        ensure => present,
                        path => "/etc/dovecot-mysql.conf",
                        content => template ("dovecot/dovecot-mysql.conf"),
        }

}
