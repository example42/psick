#
# Class collectd::redhat 
#
class collectd::redhat {

# Epel places many collectd plugins in separated packages
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
        'collectd-web' : ensure => present ;
    }

#Quick management of configdir's parent
    file { "collectd.d_parent":
        path    => "/etc/collectd",
        mode    => "755",
        owner   => "${collectd::params::configfile_owner}",
        group   => "${collectd::params::configfile_group}",
        ensure  => directory,
        require => Package["collectd"],
    }

}

