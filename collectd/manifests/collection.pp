class collectd::collection {
# Installs collection.cgi for Collectd central server

    include collectd
    include apache

    file {
        'collection.cgi':
            ensure => present,
            path => $operatingsystem ? {
                ubuntu  => "/usr/lib/cgi-bin/collection.cgi",
                debian  => "/usr/lib/cgi-bin/collection.cgi",
                centos  => "/var/www/cgi-bin/collection.cgi",
                redhat  => "/var/www/cgi-bin/collection.cgi",
                },
            mode => 0755, owner => root, group => 0,
            require => Package['apache'],
            source  => "puppet://$servername/collectd/collection.cgi",
    }

# To avoid different OS problems, collection.conf is placed in the same collection.cgi dir
    file {
        'collection.conf':
            ensure => present,
            path => $operatingsystem ? {
                ubuntu  => "/usr/lib/cgi-bin/collection.conf",
                debian  => "/usr/lib/cgi-bin/collection.conf",
                centos  => "/var/www/cgi-bin/collection.conf",
                redhat  => "/var/www/cgi-bin/collection.conf",
                },
            mode => 0644, owner => root, group => 0,
            require => Package['apache'],
            content => template("collectd/collection.conf.erb"),
    }


    package {
        'rrdtool-perl':
            name => $operatingsystem ? {
                ubuntu  => "librrds-perl",
                debian  => "librrds-perl",
                centos  => "rrdtool-perl",
                redhat  => "rrdtool-perl",
            },
            ensure => present;
    }

}
