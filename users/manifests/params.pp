# Class: users::params
#
# Defines users parameters
# In this class are defined as variables values that are used in other users classes
# This class should be included, where necessary, and eventually be enhanced with support for more OS
# You don't have generally to modify this file.
#
class users::params  {

    require common

## DEFAULTS FOR VARIABLES USERS CAN SET
# (Here are set the defaults, provide your custom variables externally)

# Define the authentication method to be used 
    $auth = $users_auth ? {
        ''      => "local",
        default => $users_auth,
    }

# Define the ldap server(s) to use (If $users_auth=ldap) 
    $ldap_servers = $users_ldap_servers ? {
        ''      => [ "ldapm.example42.com" , "ldaps.example42.com" ],
        default => $users_ldap_servers,
    }

# Define the ldap basdn to use (If $users_auth=ldap)
    $ldap_basedn = $users_ldap_basedn ? {
        ''      => "dc=example42,dc=com",
        default => $users_ldap_basedn,
    }

# Define if you want to use SSL for ldap authentication (If $users_auth=ldap)
    $ldap_ssl = $users_ldap_ssl ? {
        ''      => "no",
        default => $users_ldap_ssl,
    }

# Define if you want to use automount (If $users_auth=ldap)
    $automount = $users_automount ? {
        ''      => "no",
        default => $users_automount,
    }



## MODULES INTERNAL VARIABLES
# (Modify only to adapt to unsupported OSes)

    $ldap_cacert = $operatingsystem ? {
        'debian' => "/etc/ldap/cacert.pem",
        'ubuntu' => "/etc/ldap/cacert.pem",
        default  => "/etc/openldap/cacert.pem",
    }

    $configfile_ldap = $operatingsystem ? {
            debian => $common::osver ? {
                 8       => "/etc/ldap.conf", # Ubuntu 8.04 operatingsystem fact returns Debian
                 default => "/etc/libnss-ldap.conf",
            },
            default => "/etc/ldap.conf",
    }


## FILE SERVING SOURCE
# Sets the correct source for static files
# In order to provide files from different sources without modifying the module
# you can override the default source path setting the variable $base_source
# Ex: $base_source="puppet://ip.of.fileserver" or $base_source="puppet://$servername/myprojectmodule"
 
# What follows automatically manages the new source standard (with /modules/) from 0.25 

    case $base_source {
        '': { $general_base_source="puppet://$servername" }
        default: { $general_base_source=$base_source }
    }

    $users_source = $puppetversion ? {
        /(^0.25)/ => "$general_base_source/modules/users",
        /(^0.)/   => "$general_base_source/users",
        default   => "$general_base_source/modules/users",
    }

}
