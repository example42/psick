class exim::debian {
    file { "mailname":
        path    => "/etc/mailname",
        mode    => "${exim::params::configfile_mode}",
        owner   => "${exim::params::configfile_owner}",
        group   => "${exim::params::configfile_group}",
        require => Package[exim],
        ensure  => present,
        content => "$fqdn\n",
    }
}
