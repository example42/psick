#
# Class puppet::server::passenger 
# 
# Installs and confgiures passenger for Pupeptmaster
# Autoloaded if $puppet_passenger = yes
#
class puppet::server::passenger {
    require puppet::params

    include apache

    file { ['/etc/puppet/rack', '/etc/puppet/rack/public', '/etc/puppet/rack/tmp']:
        owner => 'puppet',
        group => 'puppet',
        ensure => directory,
    }

    file { '/etc/puppet/rack/config.ru':
        owner => 'puppet',
        group => 'puppet',
        mode => 0644,
        source => 'puppet:///modules/puppet/config.ru',
    }

    apache::vhost { 'puppetmaster.conf':
        port => '8140',
        priority => '10',
        docroot => '/etc/puppet/rack/public/',
        ssl => true,
        template => 'puppet/puppet-passenger.conf.erb',
    }

    package { "mod_passenger" : 
        ensure => present ,
        name   => $operatingsystem ? {
             debian  => "libapache2-mod-passenger",
             ubuntu  => "libapache2-mod-passenger",
             default => "rubygem-passenger",
        }
    }


}
