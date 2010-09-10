# Class: users
#
# Manages local users and external authentication methods 
#
# Usage:
# include users
#
# Variables:
# $users_auth  (default: "local") - Defines the authentication method to be used. Default uses only local authentication, set to "ldap" to ADD ldap authentication.
# $users_ldap_servers  (default: ["ldapm.example42.com","ldaps.example42.com"]) - Defines the ldap backend server(s) you want to use for ldap authentication
# $users_ldap_basedn (default: "dc=example42,dc=com") - Defines the ldap base dn for ldap authentication
# $users_ldap_ssl (default: "no") - Defines if you want to use SSL for ldap authentication 
# $users_automount (default: "no") - Set to "yes" if you want to enable homes automount
#
class users {

# Load the variables used in this module. Check the params.pp file
    include users::params

# Include the relevant subclass according to $users_auth settings
    case $users::params::auth {
        ldap: { include users::ldap }
# TODO  ads: { include users::ads }
# TODO  nis: { include users::nis }
    }

# Autoloads users::$my_project if $my_project is defined
# Place in users::$my_project your customizatios
    if $my_project { include "users::${my_project}" }

}
