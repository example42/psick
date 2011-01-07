#
# Class: openldap::samba
#
# Adds schemas needed by Samba
#
# Usage:
# Automatically included if $openldap_support_samba = "yes"
#
class openldap::samba {

    # Load the variables used in this module. Check the params.pp file 
    require openldap::params

    file { "samba.schema":
        path    => "${openldap::params::configdir}/schema/samba.schema",
        mode    => "644",
        owner   => "root",
        group   => "root",
        require => Package[openldap],
        ensure  => present,
        source  => "${openldap::params::general_base_source}/openldap/schema/samba.schema",
        notify  => Service["openldap"],
    }

}
