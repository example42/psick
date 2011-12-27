class postgresql::redhat {

    exec { "postgresql_initdb":
        command => "${postgresql::params::initdbcommand}",
        creates => "${postgresql::params::configfile}",
        path    => ["/sbin", "/bin", "/usr/bin", "/usr/sbin"],
        require => Package["postgresql"],
        before  => Service["postgresql"],
        
    }

}
