class puppet {
# Manages Puppet client
# Requires: $puppet_server

    package {
        puppet:
        name => $operatingsystem ? {
            solaris => "CSWpuppet",
            default    => "puppet",
            },
        ensure => present;
    }

    service { puppet:
        name => $operatingsystem ? {
            solaris => "puppetd",
            default => "puppet",
            },
        ensure => running,
        enable => true,
        hasrestart => true,
        require => Package[puppet],
    }

    file {    
             "puppet.conf":
#            mode => 644, owner => root, group => root,
            require => Package[puppet],
            ensure => present,
            path => $operatingsystem ?{
                freebsd => "/usr/local/etc/puppet/puppet.conf",
                default => "/etc/puppet/puppet.conf",
            },
            content => $puppet_server ?{
                $fqdn     => template("puppet/master/puppet.conf.erb"),
                default   => template("puppet/puppet.conf.erb"),
            },
            notify  => Service["puppet"],
    }

    file {
        "namespaceauth.conf":
#            mode => 644, owner => root, group => root,
            require => Package[puppet],
            path => $operatingsystem ?{
                freebsd => "/usr/local/etc/puppet/namespaceauth.conf",
                default => "/etc/puppet/namespaceauth.conf",
            },
            content => $puppet_server ?{
                $fqdn     => template("puppet/master/namespaceauth.conf.erb"),
                default   => template("puppet/namespaceauth.conf.erb"),
            },
            notify  => Service["puppet"],
    }
}


class puppet::doc {
# Installs rdoc for puppetdoc

    package {
        rdoc:
        name => $operatingsystem ? {
            Debian  => "rdoc",
            CentOS  => "ruby-rdoc",
            SuSE    => "ruby",
            default => "ruby-rdoc",
            },
        ensure => present,
    }
}

