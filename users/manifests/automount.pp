# Class: users::automount
#
# Manages users' home directory automount 
#
# Usage:
# Set $users_auth = "ldap" and $users_automount = "yes" and
# include users
# NOTE/TODO: This class is made for automounter based on ldap. When and if other auth methods will be supported this class will be refactored.
# 
# Variables:
# $users_automount (default: "no") - Set to "yes" if you want to enable homes automount
#
class users::automount {

# Load the variables used in this module. Check the params.pp file
    include users::params

    $users_ldap_servers = $users::params::ldap_servers
    $users_ldap_basedn = $users::params::ldap_basedn
    $users_ldap_ssl = $users::params::ldap_ssl 
    $users_automount = $users::params::automount 

# Required packages
    case $operatingsystem {
        ubuntu,debian: {
             package { "autofs": ensure => present }
             package { "autofs-ldap": ensure => present }
        }
        redhat,centos: {
        }
    }

}

