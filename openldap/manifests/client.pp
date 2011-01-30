#
# Class: openldap::client
#
# Installs openldap client package
#
# Usage:
# include openldap::client
#
class openldap::client {

    # Load the variables used in this module. Check the params.pp file
    require openldap::params

    package { "openldap-client":
        name   => "${openldap::params::packagenameclient}",
        ensure => present,
    }

}
