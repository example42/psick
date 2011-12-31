#
# Class: openldap::ssl
#
# Adds SSL support (Certs files and keys are not provided by default)
#
# Usage:
# Automatically included if $openldap_use_ssl = "yes"
#
class openldap::ssl {

    # Load the variables used in this module. Check the params.pp file 
    require openldap::params

    file { "openldap.ssl.certdir":
        path    => "${openldap::params::certsdir}",
        ensure  => directory,
        require => Package["openldap"],
    }

    file { "openldap.ca.cert":
        path    => "${openldap::params::certsdir}/cacert.pem",
        mode    => "644",
        owner   => "root",
        group   => "root",
        require => File["openldap.ssl.certdir"],
        ensure  => present,
        # source  => "${openldap::params::general_base_source}/openldap/certs/cacert.pem",
        notify  => Service["openldap"],
    }

    file { "openldap.ssl.cert":
        path    => "${openldap::params::certsdir}/slapd-cert.pem",
        mode    => "644",
        owner   => "root",
        group   => "root",
        require => File["openldap.ssl.certdir"],
        ensure  => present,
        # source  => "${openldap::params::general_base_source}/openldap/certs/slapd-cert.pem",
        notify  => Service["openldap"],
    }

    file { "openldap.ssl.key":
        path    => "${openldap::params::certsdir}/slapd-key.pem",
        mode    => "640",
        owner   => "root",
        group   => "${openldap::params::username}",
        require => File["openldap.ssl.certdir"],
        ensure  => present,
        # source  => "${openldap::params::general_base_source}/openldap/certs/slapd-key.pem",
        notify  => Service["openldap"],
    }

    # Include project specific monitor class if $my_project is set
    if $my_project { include "openldap::${my_project}::ssl" }

}
