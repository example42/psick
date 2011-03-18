# manifests/updatesd/disable.pp

class yum::updatesd::disable inherits yum::updatesd {
    Package['yum-updatesd']{
        ensure => absent,
    }

    Service['yum-updatesd']{
        ensure => stopped,
        enable => false,
        require => undef,
    }
}

