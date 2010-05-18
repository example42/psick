# Class: cacti::base
#
# Base cacti class. Installs package, runs service, defines main configuration file.
# Note that it doesn't modify, by default, the main configuration file,
# in order to do it, add a source|content statement for the relevant File type in this class or in a class that inherits it.
# This class is included by main cacti class, it's not necessary to call it directly
#
class cacti::base  {

    include apache::php
    include mysql

    package { cacti:
        name   => $operatingsystem ? {
            default    => "cacti",
            },
        ensure => present,
    }

    cacti::conf { "database_hostname":  value => "$cacti_mysqlhost" }
    cacti::conf { "database_default":  value => "$cacti_mysqldbname" }
    cacti::conf { "database_username":  value => "$cacti_mysqluser" }
    cacti::conf { "database_password":  value => "$cacti_mysqlpassword" }

}

