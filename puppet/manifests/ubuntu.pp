class puppet::ubuntu {

    file {
        "default-puppet":
        path    => "/etc/default/puppet",
        require => Package[puppet],
        ensure  => present,
        source  => "${puppet::params::general_base_source}/puppet/default-puppet",
        mode    => "${puppet::params::configfile_mode}",
        owner   => "${puppet::params::configfile_owner}",
        group   => "${puppet::params::configfile_group}",
        notify  => Service["puppet"],
    }

}
