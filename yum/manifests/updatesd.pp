# Class yum::updatesd
#
# Installs and enables yum updatesd
# 
#
class yum::updatesd {

    package {"yum-updatesd":
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
        source  => "${yum::params::general_base_source}/yum/yum-updatesd.conf",
        require => Package['yum-updatesd'],
    }

}
