# Class yum::updatesd
#
# Installs and enables yum updatesd
# 
#
class yum::updatesd {

    require yum::params
    require common

    package { "yum-updatesd":
        name => $common::osver ? {
            5 => "yum-updatesd",
        },
        ensure => present,
    }

    service {"yum-updatesd":
        ensure  => running,
        enable  => true,
        require => Package['yum-updatesd'],
    }

    file {"yum-updatesd.conf":
        path   => "/etc/yum/yum-updatesd.conf",
        ensure => present,
        source  => "${common::source}/yum/yum-updatesd.conf",
        require => Package['yum-updatesd'],
    }

}
