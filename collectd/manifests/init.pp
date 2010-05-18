import "*.pp"

class collectd {

case $operatingsystem {
    ubuntu: { $collectd_configdir = "/etc/collectd" }
    debian: { $collectd_configdir = "/etc/collectd" }
    centos: { $collectd_configdir = "/etc" }
    redhat: { $collectd_configdir = "/etc" }
    suse: { $collectd_configdir = "/etc" }
}

    package {
        'collectd':
            name => $operatingsystem ? {
                default => "collectd",
            },
            ensure => present;
    }

# In some OS (such as RedHat with EPEL) some plugins are provided in different packages
# For sake of simplicity we install everything. May be tuned.

    case $operatingsystem {
        redhat,centos: {
            package {
                'collectd-apache' : ensure => present ;
                'collectd-dns' : ensure => present ;
                'collectd-email' : ensure => present ;
                'collectd-ipmi' : ensure => present ;
                'collectd-mysql' : ensure => present ;
                'collectd-nginx' : ensure => present ;
                'collectd-nut' : ensure => present ;
                'collectd-postgresql' : ensure => present ;
                'collectd-rrdtool' : ensure => present ;
                'collectd-sensors' : ensure => present ;
                'collectd-snmp' : ensure => present ;
                'collectd-virt' : ensure => present ;
            }
        }
        default: {  }
    }


    service {
        'collectd':
            ensure => running,
            enable => true,
            hasrestart => true,
            pattern => collectd,
            require => Package['collectd'];
    }

    file {
        'collectd.conf':
            ensure => present,
            path => "$collectd_configdir/collectd.conf",
#            mode => 0644, owner => root, group => 0,
            require => Package['collectd'],
            notify => Service['collectd'],
            content => template("collectd/collectd.conf"),
    }




# Brutal force of /etc/collectd.d/ directory for plugins
# To adapt or accept

    file {
        'collectd.d':
            path => "$collectd_configdir/collectd.d",
            ensure => directory,
    }

}
