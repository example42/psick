#
# Class: nrpe::extra
#
# Some extra stuff necessary for Example42 Nagios implementation
# Needed to make things go smoothly 
#
# Usage:
# Autoincluded by nrpe class
#
class nrpe::extra {

    file { "extra.cfg":
        path    => "${nrpe::params::configdir}/extra.cfg",
        mode    => "${nrpe::params::configfile_mode}",
        owner   => "${nrpe::params::configfile_owner}",
        group   => "${nrpe::params::configfile_group}",
        ensure  => present,
        require => File["nrpe.d"],
        notify  => Service["nrpe"],
        content => template("nrpe/extra.cfg.erb"),
    }

}
