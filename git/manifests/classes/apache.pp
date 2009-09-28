# Class for a public git repository with Apache web interface

class git::apache {
	
	include apache
	include git::server

	package { gitweb:
		name => $operatingsystem ? {
			default	=> "gitweb",
			},
		ensure => present,
	}

        file {
                "git.conf":
                        owner   => $operatingsystem ?{
                                default => "root",
                                },
                        group   => $operatingsystem ?{
                                default => "root",
                                },
                        mode    => 644,
                        ensure  => present,
                        path    => $operatingsystem ?{
                                default => "/etc/httpd/conf.d/git.conf",
                                },
                        source  => "puppet://$server/git/git.conf.httpd",
			notify  => Service["apache"],
        }

        file  { "/pub":
                path => "/pub",
                mode => 755, owner => root, group => root,
                ensure => directory,
        }

        file  { "/pub/git":
                path => "/pub/git",
                mode => 755, owner => root, group => root,
                ensure => "/srv/git",
                # ensure => ${git_basedir},
                require => File["/pub"],
        }

}
