#
# Class: openldap::solaris_clients
#
# Adds schemas need when Solaris clients are involved
#
# Usage:
# Automatically included if $openldap_support_solaris_clients = "yes"
#
class openldap::solaris_clients {

    # Load the variables used in this module. Check the params.pp file 
    require openldap::params

    file { "DUAConfigProfile.schema":
        path    => "${openldap::params::configdir}/schema/DUAConfigProfile.schema",
        mode    => "644",
        owner   => "root",
        group   => "root",
        require => Package[openldap],
        ensure  => present,
        source  => "${openldap::params::general_base_source}/openldap/schema/DUAConfigProfile.schema",
        notify  => Service["openldap"],
    }

    file { "solaris.schema":
        path    => "${openldap::params::configdir}/schema/solaris.schema",
        mode    => "644",
        owner   => "root",
        group   => "root",
        require => Package[openldap],
        ensure  => present,
        source  => "${openldap::params::general_base_source}/openldap/schema/solaris.schema",
        notify  => Service["openldap"],
    }

    file { "solaris_automount.schema":
        path    => "${openldap::params::configdir}/schema/solaris_automount.schema",
        mode    => "644",
        owner   => "root",
        group   => "root",
        require => Package[openldap],
        ensure  => present,
        source  => "${openldap::params::general_base_source}/openldap/schema/solaris_automount.schema",
        notify  => Service["openldap"],
    }

}
