# Class: controltier::client::key
#
# Installs controltier server key on client nodes for remote management
# At the moment this is done sourcing a static key filei (quick & dirty)
# TODO: Manage keys with ssh::auth or another smart way
#
# Usage:
# Automatically included by controltier::client
#
class controltier::client::key {

    require controltier::params

    file { "ctier_sshdir":
        path    => "${controltier::params::root}/.ssh",
        ensure  => directory,
        owner   => "${controltier::params::user}",
        group   => "${controltier::params::user}",
        mode    => "700",
        require => Package["controltier_client"],
    }

    file { "ctier_sshkey":
        path    => "${controltier::params::root}/.ssh/authorized_keys",
        ensure  => present,
        owner   => "${controltier::params::user}",
        group   => "${controltier::params::user}",
        mode    => 600,
        require => File["ctier_sshdir"],
        source  => "${controltier::params::controltier_source}/authorized_keys",
    }

}
