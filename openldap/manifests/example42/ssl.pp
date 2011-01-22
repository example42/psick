#
# Class: openldap::example42::ssl
#
class openldap::example42::ssl inherits openldap::ssl {

    # Load the variables used in this module. Check the params.pp file 
    require openldap::params
    require users::params

    File["openldap.ca.cert"] {
        # CA cert is already provided by users::ldap class
        source  => "${users::params::users_source}/ldap/cacert.pem",
        # source  => "${openldap::params::general_base_source}/openldap/example42/cacert.pem",
    }

    File["openldap.ssl.cert"] {
        source  => "${openldap::params::general_base_source}/openldap/example42/slapd-cert.pem",
    }

    File["openldap.ssl.key"] {
        # source  => "${openldap::params::general_base_source}/openldap/example42/slapd-key.pem",
    }

}
