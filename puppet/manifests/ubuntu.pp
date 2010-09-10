class puppet::ubuntu {

    file {
        "default-puppet":
        path    => "/etc/default/puppet",
        require => Package[puppet],
        ensure  => present,
        source  => "${puppet::params::puppet_source}/default-puppet",
        notify  => Service["puppet"],
    }

}
