# Class openldap::ubuntu
#
# This class is automatically loaded on Ubunut 10.04 and
# configures OpenLdap to use the "old" style slapd.conf for 
# configurations, instad of the ldap based backend (dn=config)
#
class openldap::ubuntu {

    include openldap::params

    file {
        "default-openldap":
        path    => "/etc/default/slapd",
        require => Package[openldap],
        ensure  => present,
        source  => "${openldap::params::general_base_source}/openldap/openldap-default",
        mode    => "644",
        owner   => "root",
        group   => "root",
        notify  => Service["openldap"],
    }

}

