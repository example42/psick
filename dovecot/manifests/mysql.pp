# Class: dovecot::mysql
#
# This class sets up a Dovecot with Mysql backend.
# The configurations used follow the standards set and necessary by the software postfixadmin
# Postfix Admin homepage: http://sourceforge.net/projects/postfixadmin/
#
# PREREQUISITES
# You need to set the following variables (here with example values)
# This class is specifically oriented to the setup of a all-in-one box with 
# Postfix + Mysql + PostfixAdmin + Dovecot so you just need the varibles set for postfix::mysql 
# $postfix_mysqluser = "dovecot"
# $postfix_mysqlpassword = "example42"
# $postfix_mysqlhost = "127.0.0.1"
# $postfix_mysqldbname = "dovecot"
# $postfix_mynetworks = $network/$netmask
#
class dovecot::mysql inherits dovecot {

    File["dovecot.conf"] {
            source => [ "puppet://$servername/dovecot/dovecot.conf-mysql-$operatingsystem" , "puppet://$servername/dovecot/dovecot.conf-mysql" ],
    }

    file {
        "dovecot-mysql.conf":
            mode => 644, owner => root, group => root,
            require => File["dovecot.conf"],
            ensure => present,
            path => "/etc/dovecot-mysql.conf",
            content => template ("dovecot/dovecot-mysql.conf"),
    }

}

