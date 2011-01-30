#
# Class bind::file
#
# This class provides named.conf as a normal template
# It's used if $bind_config = "file"
#
class bind::file {

    include bind::params 

    file { "named.conf":
        path    => "${bind::params::configfile}",
        mode    => "${bind::params::configfile_mode}",
        owner   => "${bind::params::configfile_owner}",
        group   => "${bind::params::configfile_group}",
        ensure  => present,
        require => Package["bind"],
        notify  => Service["bind"],
        content => template("bind/named.conf.erb"),
    }
}
