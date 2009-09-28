class git::server inherits git {

	include xinetd

        package { git-daemon:
                name => $operatingsystem ? {
                        default => "git-daemon",
                        },
                ensure => present,
        }

        file {
                "/etc/xinetd.d/git":
                        mode => 644, owner => root, group => root,
                        require => Package["git-daemon"],
                        ensure => present,
                        source => "puppet://$server/git/xinetd" ,
        }

}
