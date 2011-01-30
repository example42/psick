#
# Class iptables::file
#
# This class configures iptables via a base rule file
# The file itselt is not provided. Use this class (or, better,
# your custom $my_project class that inherits this) to 
# manage the iptables file in the way you want
# 
# It's used if $iptables_config = "file"
#
class iptables::file {

    include iptables::params 

    file { "iptables_rules":
        path    => "${iptables::params::configfile}",
        mode    => "${iptables::params::configfile_mode}",
        owner   => "${iptables::params::configfile_owner}",
        group   => "${iptables::params::configfile_group}",
        ensure  => present,
        require => Package["iptables"],
        notify  => Service["iptables"],
    }
}
