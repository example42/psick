class puppet::ubuntu {

    file {
        "default-puppet":
        path    => "/etc/default/puppet",
        require => Package[puppet],
        ensure  => present,
        source  => "${puppet::params::general_base_source}/puppet/default-puppet",
        notify  => Service["puppet"],
    }

}
