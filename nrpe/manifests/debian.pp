# Class nrpe::debian
#
# Managed init config file for Debian/Ubuntu
#
class nrpe::debian {

    include nrpe::params

    file { "nrpe.init":
        path    => "${nrpe::params::initconfigfile}",
        mode    => "${nrpe::params::configfile_mode}",
        owner   => "${nrpe::params::configfile_owner}",
        group   => "${nrpe::params::configfile_group}",
        ensure  => present,
        require => Package["nrpe"],
        notify  => Service["nrpe"],
        content => template("nrpe/nrpe-init-debian.erb"),
    }

}
