class puppet {

	package {
		puppet:
		name => $operatingsystem ? {
			default	=> "puppet",
			},
		ensure => present;

		ruby-rdoc:
		name => $operatingsystem ? {
			default	=> "ruby-rdoc",
			},
		ensure => present,
	}

	service { puppet:
		name => $operatingsystem ? {
                        default => "puppet",
                        },
		ensure => running,
		enable => true,
		hasrestart => true,
		hasstatus => true,
		require => Package[puppet],
	}

	file {	
             	"puppet.conf":
			mode => 644, owner => root, group => root,
			require => Package[puppet],
			ensure => present,
			path => $operatingsystem ?{
                        	default => "/etc/puppet/puppet.conf",
                        },
			content => template("puppet/puppet.conf"),
			notify  => Service["puppet"],
	}

        file {
                "namespaceauth.conf":
                        mode => 640, owner => root, group => root,
                        require => Package[puppet],
                        path => $operatingsystem ?{
                                default => "/etc/puppet/namespaceauth.conf",
                        },
                        content => template("puppet/namespaceauth.conf"),
        }


#	include puppet::extracode

}


class puppet::master inherits puppet {

	package { 
		puppet-server:
		name => $operatingsystem ? {
			default	=> "puppet-server",
			},
		ensure => present;

		rrdtool-ruby:
		name => $operatingsystem ? {
			default	=> "rrdtool-ruby",
			},
		ensure => present;
	}

	service { puppetmaster:
		name => $operatingsystem ? {
                        default => "puppetmaster",
                        },
		ensure => running,
		enable => true,
		hasrestart => true,
		hasstatus => true,
		require => Package[puppet-server],
	}

	File["puppet.conf"] {
                        content => template("puppet/puppet.conf-master"),
			notify  => Service["puppetmaster"],
	}

	File["namespaceauth.conf"] {
			content => template("puppet/namespaceauth.conf-master"),
			notify  => [ Service["puppet"], Service["puppetmaster"] ] ,
	}

	file {	
             	"tagmail.conf":
			mode => 640, owner => root, group => root,
			require => Package[puppet],
			path => $operatingsystem ?{
                        	default => "/etc/puppet/tagmail.conf",
                        },
			content => template("puppet/tagmail.conf"),
	}

}



class puppet::extracode {
	# Old "manual" plugin & functions include. Should not be necessary anymore

        file {
                "/var/lib/puppet/lib/plugins":
                        mode => 755, owner => root, group => root,
                        require => Package[puppet],
                        ensure => directory,
                        path => $operatingsystem ?{
                                default => "/var/lib/puppet/lib/plugins",
                        },
        }

        file {
                "puppet/functions":
                        mode => 755, owner => root, group => root,
                        require => Package[puppet],
                        ensure => directory,
                        path => $operatingsystem ?{
                                default => "$rubysitedir/puppet/parser/functions",
                        },
        }

# Davids
        file {
                "slash_escape.rb":
                        mode => 644, owner => root, group => root,
                        require => Package[puppet],
                        path => $operatingsystem ?{
                                default => "$rubysitedir/puppet/parser/functions/slash_escape.rb",
                        },
                        source => "puppet://$server/puppet/functions/slash_escape.rb",
        }

# Lab
        file {
                "regexp_escape.rb":
                        mode => 644, owner => root, group => root,
                        require => Package[puppet],
                        path => $operatingsystem ?{
                                default => "$rubysitedir/puppet/parser/functions/regexp_escape.rb",
                        },
                        source => "puppet://$server/puppet/functions/regexp_escape.rb",
        }

# Thomas 

        file {
                "regexp_quote.rb":
                        mode => 644, owner => root, group => root,
                        require => Package[puppet],
                        path => $operatingsystem ?{
                                default => "$rubysitedir/puppet/parser/functions/regexp_quote.rb",
                        },
                        source => "puppet://$server/puppet/functions/regexp_quote.rb",
        }

        file {
                "sprintf.rb":
                        mode => 644, owner => root, group => root,
                        require => Package[puppet],
                        path => $operatingsystem ?{
                                default => "$rubysitedir/puppet/parser/functions/sprintf.rb",
                        },
                        source => "puppet://$server/puppet/functions/sprintf.rb",
        }

        file {
                "strftime.rb":
                        mode => 644, owner => root, group => root,
                        require => Package[puppet],
                        path => $operatingsystem ?{
                                default => "$rubysitedir/puppet/parser/functions/strftime.rb",
                        },
                        source => "puppet://$server/puppet/functions/strftime.rb",
        }

# Thomas Types
        file {
                "delete_lines.rb":
                        mode => 644, owner => root, group => root,
                        require => Package[puppet],
                        path => $operatingsystem ?{
                                default => "/var/lib/puppet/lib/plugins/type/delete_lines.rb",
                        },
                        source => "puppet://$server/puppet/types/delete_lines.rb",
        }

        file {
                "ensure_line.rb":
                        mode => 644, owner => root, group => root,
                        require => Package[puppet],
                        path => $operatingsystem ?{
                                default => "/var/lib/puppet/lib/plugins/type/ensure_line.rb",
                        },
                        source => "puppet://$server/puppet/types/ensure_line.rb",
        }
        
	file {
                "regexp_replace_lines.rb":
                        mode => 644, owner => root, group => root,
                        require => Package[puppet],
                        path => $operatingsystem ?{
                                default => "/var/lib/puppet/lib/plugins/type/regexp_replace_lines.rb",
                        },
                        source => "puppet://$server/puppet/types/regexp_replace_lines.rb",
        }
        
	file {
                "replace_sections.rb":
                        mode => 644, owner => root, group => root,
                        require => Package[puppet],
                        path => $operatingsystem ?{
                                default => "/var/lib/puppet/lib/plugins/type/replace_sections.rb",
                        },
                        source => "puppet://$server/puppet/types/replace_sections.rb",
        }
}
