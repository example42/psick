# Class openldap::bdb
#
# This class is automatically if ${openldap::params::db_backend} is bdb or hdb
# It creates the config/optimization file for BDB
#
class openldap::bdb {

    include openldap::params

    file {
        "DD_CONFIG":
        path    => "${openldap::params::datadir}/DB_CONFIG",
        require => Package["openldap"],
        ensure  => present,
        source  => "${openldap::params::general_base_source}/openldap/DB_CONFIG",
        mode    => "644",
        owner   => "${openldap::params::configfile_group}",
        group   => "${openldap::params::configfile_group}",
        notify  => Service["openldap"],
    }

}

