# Class: exim::ldap
#
# Manages exim via ldap 
#
# Usage:
# Check users module
#
class exim::ldap {

# Load the variables used in this module. Check the params.pp file
    include exim::params

    include exim

# We imply automount is made via nfs
    include nfs::client

# We mount users directories under /ldap (by default)
    file { "/automountdir":
        path    => "${exim::params::mountdir}",
        mode    => "755",
        owner   => "root",
        group   => "root",
        ensure  => directory,
    }

# exim init.d configuration file . TODO Standardize init.d config files - Test/Fix on RHEL
    file { "exim-initd":
        path    => $operatingsystem ? {
            debian  => "/etc/default/exim",
            ubuntu  => "/etc/default/exim",
            default => "/etc/sysconfig/exim",
        },
        mode    => "644",
        owner   => "root",
        group   => "root",
        ensure  => present,
        content => $operatingsystem ? {
            debian  => template("exim/ldap/exim_initd-debian.erb"),
            ubuntu  => template("exim/ldap/exim_initd-debian.erb"),
            default => template("exim/ldap/exim_initd-redhat.erb"),
        },
    }

    case $operatingsystem {
        ubuntu,debian: {
             package { "exim-ldap": ensure => present }
        }
        redhat,centos: {
        }
    }

}

