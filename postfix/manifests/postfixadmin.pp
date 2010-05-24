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
        url                 => "http://downloads.sourceforge.net/project/postfixadmin/postfixadmin/postfixadmin_2.3.tar.gz",
        extracted_dir       => "postfixadmin-2.3",
        postextract_command => "ln -s postfixadmin-2.3 ../postfixadmin",
        destination_dir     => "${apache::params::documentroot}",
        require             => Package["apache"],
    }

    mysql::grant { postfixadmin:
        mysql_db         => $postfix_mysqldbname,
        mysql_user       => $postfix_mysqluser,
        mysql_password   => $postfix_mysqlpassword,
        mysql_host       => $postfix_mysqlhost,
        mysql_privileges => "ALL",
    }


# Postfixadmin config file configuration

    file { "postfixadminconf":
        ensure  => present,
        require => Netinstall["postfixadmin"],
        path    => "${postfix::params::postfixadminconf}",
    }

    postfixadmin::conf { "database_host": value => "$postfix_mysqlhost" }
    postfixadmin::conf { "database_name": value => "$postfix_mysqldbname" }
    postfixadmin::conf { "database_user": value => "$postfix_mysqluser" }
    postfixadmin::conf { "database_password": value => "$postfix_mysqlpassword" }
    postfixadmin::conf { "configured": value => "true" , quote => "no" }
    postfixadmin::conf { "domain_path": value => "YES" }
    postfixadmin::conf { "domain_in_mailbox": value => "NO" }

}
