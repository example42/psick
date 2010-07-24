# Class: puppet::foreman
#
# Installs Foreman and configures Puppet for Foreman support
#
# Usage for Foreman without external nodes support
# include puppet::foreman 
#
# Usage for Foreman WITH external nodes support
# include puppet::foreman::externalnodes 
#
# Compatibility: RedHat/Centos
#
class puppet::foreman inherits puppet::master {

    file {
        "/etc/yum.repos.d/foreman.repo":
        mode => 644, owner => root, group => root,
        ensure => present,
        source => "puppet://$servername/foreman/foreman.repo",
    }

    package { foreman:
        name => "foreman",
        ensure => present,
        require => $operatingsystem ? {
            default => File["/etc/yum.repos.d/foreman.repo"],
        },
    }

    service { foreman:
        name => "foreman",
        ensure => running,
        enable => true,
        require => Package["foreman"],
    }

    File["puppet.conf"] {
            content => template("puppet/foreman/puppet.conf.erb"),
            notify  => Service["puppetmaster"],
    }

}

