# Class: postfix::postfixadmin
#
# This class installs and configures Postfix Admin Web Interface to manage postfix with Mysql backend
# Postfix Admin homepage: http://sourceforge.net/projects/postfixadmin/
#
# PREREQUISITES
# You need to set the following variables (here with example values)
# $postfix_mysqluser = "postfix"
# $postfix_mysqlpassword = "example42"
# $postfix_mysqlhost = "127.0.0.1"
# $postfix_mysqldbname = "postfix"
# $postfix_mynetworks = $network/$netmask
#
# This class requires Example42 apache module (just for the php::module define) and Example42 common module (for the netinstall and config defines)
#
# You may have these components on separated servers or included on the same host
# Postfix (with Mysql support): include postfix::mysql
# Mysql: include mysql
# Apache+PHP+PostfixAdmin Web interface with Mysql support: include postfix::postfixadmin
#
class postfix::postfixadmin {

    require apache
    require apache::params
    require postfix::params

    case $operatingsystem {
        debian: { php::module  { [ mysql, imap ]: } }
        ubuntu: { php::module  { [ mysql, imap ]: } }
        default: { php::module  { [ mysql, mbstring, imap ]: } }
    }

    netinstall { postfixadmin:
        url                 => "{postfix::params::postfixadmin_url}"",
        extracted_dir       => "${postfix::params::postfixadmin_dirname}",
        postextract_command => "ln -s ${postfix::params::postfixadmin_dirname} ../postfixadmin",
        destination_dir     => "${apache::params::documentroot}",
        require             => Package["apache"],
    }

    mysql::grant { postfixadmin:
        mysql_db         => "${postfix::params::mysqldbname}",
        mysql_user       => "${postfix::params::mysqluser}",
        mysql_password   => "${postfix::params::mysqlpassword}",
        mysql_host       => "${postfix::params::mysqlhost}",
        mysql_privileges => "ALL",
    }


# Postfixadmin config file configuration

    file { "postfixadminconf":
        ensure  => present,
        require => Netinstall["postfixadmin"],
        path    => "${postfix::params::postfixadminconf}",
    }

    postfix::postfixadminconf { "database_host": value => "${postfix::params::mysqlhost}" }
    postfix::postfixadminconf { "database_name": value => "${postfix::params::mysqldbname}" }
    postfix::postfixadminconf { "database_user": value => "${postfix::params::mysqluser}" }
    postfix::postfixadminconf { "database_password": value => "${postfix::params::mysqlpassword}" }
    postfix::postfixadminconf { "configured": value => "true" , quote => "no" }
    postfix::postfixadminconf { "domain_path": value => "YES" }
    postfix::postfixadminconf { "domain_in_mailbox": value => "NO" }

}
