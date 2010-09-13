# Class: users::ldap
#
# Manages ldap authentication 
#
# Usage:
# Set $users_auth = "ldap" and
# include users
#
# Variables:
# $users_ldap_servers  (default: ["ldapm.example42.com","ldaps.example42.com"]) - Defines the ldap backend server(s) you want to use for ldap authentication
# $users_ldap_basedn (default: "dc=example42,dc=com") - Defines the ldap base dn for ldap authentication
# $users_ldap_ssl (default: "no") - Defines if you want to use SSL for ldap authentication 
# $users_automount (default: "no") - Set to "yes" if you want to enable homes automount
#
class users::ldap {

# Load the variables used in this module. Check the params.pp file
    include users::params

    $users_ldap_servers = $users::params::ldap_servers
    $users_ldap_basedn = $users::params::ldap_basedn
    $users_ldap_ssl = $users::params::ldap_ssl 
    $users_ldap_cacert = $users::params::ldap_cacert 
    $users_automount = $users::params::automount 

# PAM's configurations for ldap are managed in the dedicated pam::ldap class
    include pam::ldap

# Include autofs::ldap if $users_automount = "yes"
    if $users::params::automount == "yes" { include "autofs::ldap" }

# Systems' config files for LDAP 
    file { "nsswitch.conf":
        path    => "/etc/nsswitch.conf",
        mode    => "644",
        owner   => "root",
        group   => "root",
        require => [ File["libnss_ldap.conf"] ],
        ensure  => present,
        content => template("users/ldap/nsswitch.conf.erb"),
    }

    file { "libnss_ldap.conf":
        path    => $operatingsystem ? {
            debian => "/etc/libnss_ldap.conf",
            ubuntu => "/etc/libnss_ldap.conf",
            redhat => "/etc/ldap.conf",
            centos => "/etc/ldap.conf",
        },
        mode    => "644",
        owner   => "root",
        group   => "root",
        ensure  => present,
        content => template("users/ldap/libnss_ldap.conf.erb"),
    }

# Seems like also this file is needed on Ubuntu/Debian. Same as libnss_ldap.conf.erb
    file { "pam_ldap.conf":
        path    => $operatingsystem ? {
            debian => "/etc/pam_ldap.conf",
            ubuntu => "/etc/pam_ldap.conf",
            redhat => "/etc/pam_ldap.conf",
            centos => "/etc/pam_ldap.conf",
        },
        mode    => "644",
        owner   => "root",
        group   => "root",
        ensure  => present,
        content => template("users/ldap/libnss_ldap.conf.erb"),
    }

# Openldap client config
    file { "openldap-ldap.conf":
        path    => $operatingsystem ? {
            debian => "/etc/ldap/ldap.conf",
            ubuntu => "/etc/ldap/ldap.conf",
            redhat => "/etc/openldap/ldap.conf",
            centos => "/etc/openldap/ldap.conf",
        },
        mode    => "644",
        owner   => "root",
        group   => "root",
        ensure  => present,
        content => template("users/ldap/openldap-ldap.conf.erb"),
    }

# TODO: Provide a sample cacert.pem file
    case $users_ldap_ssl {
        yes: {
            file { "ldap_cacert":
                path    => "${users::params::ldap_cacert}",
                mode    => "644",
                owner   => "root",
                group   => "root",
                ensure  => present,
                source => "${users::params::users_source}/ldap/cacert.pem",
            }
        }
    }


# Required packages
    case $operatingsystem {
        Ubuntu,Debian: {
             package { "libpam-ldap": ensure => present }
             package { "libnss-ldap": ensure => present }
             package { "ldap-utils": ensure => present }
        }
        redhat,centos: {
             package { "nss_ldap": ensure => present }
        }
    }

}

