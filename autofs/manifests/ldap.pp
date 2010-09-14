# Class: autofs::ldap
#
# Manages autofs via ldap 
#
# Usage:
# Check users module
#
class autofs::ldap {

# Load the variables used in this module. Check the params.pp file
    include autofs::params

# We imply automount is made via nfs
    include nfs::client

# We mount users directories under /ldap (by default)
    file { "/automountdir":
        path    => "${autofs::params::mountdir}",
        mode    => "755",
        owner   => "root",
        group   => "root",
        ensure  => directory,
    }

# autofs init.d configuration file . TODO Standardize init.d config files - Test/Fix on RHEL
    file { "autofs-initd":
        path    => $operatingsystem ? {
            debian  => "/etc/default/autofs",
            ubuntu  => "/etc/default/autofs",
            default => "/etc/sysconfig/autofs",
        },
        mode    => "644",
        owner   => "root",
        group   => "root",
        ensure  => present,
        content => $operatingsystem ? {
            debian  => template("autofs/ldap/autofs_initd-debian.erb"),
            ubuntu  => template("autofs/ldap/autofs_initd-debian.erb"),
            default => template("autofs/ldap/autofs_initd-redhat.erb"),
        },
    }

    case $operatingsystem {
        ubuntu,debian: {
             package { "autofs-ldap": ensure => present }
        }
        redhat,centos: {
        }
    }

}

