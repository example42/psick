class collectd::collection {
# Installs collection.cgi for Collectd central server

    include apache
    include collectd::params

    file { "collection.cgi":
        ensure  => present,
        path    => "${collectd::params::collectiondir}/collection.cgi",
        mode    => "755",
        owner   => "${collectd::params::configfile_owner}",
        group   => "${collectd::params::configfile_group}",
        require => Package['apache'],
        source  => "puppet://$servername/collectd/collection.cgi",
    }

# To avoid different OS problems, collection.conf is placed in the same collection.cgi dir
    file { "collection.conf":
        ensure  => present,
        path    => "${collectd::params::collectiondir}/collection.conf",
        mode    => "644",
        owner   => "${collectd::params::configfile_owner}",
        group   => "${collectd::params::configfile_group}",
        require => Package['apache'],
        content => template("collectd/collection.conf.erb"),
    }

# Quick and dirty dependencies setup
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
