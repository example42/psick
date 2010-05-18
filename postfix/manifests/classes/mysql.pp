# Class: postfix::mysql
#
# This class sets up a Postfix with Mysql backend.
# The configurations used follow the standards set and necessary by the software postfixadmin
# Postfix Admin homepage: http://sourceforge.net/projects/postfixadmin/
# You mayb need to include postfix::postfixadmin to set up the Postfix Admin web interface
#
# PREREQUISITES
# You need to set the following variables (here with example values)
# $postfix_mysqluser = "postfix"
# $postfix_mysqlpassword = "example42"
# $postfix_mysqlhost = "127.0.0.1"
# $postfix_mysqldbname = "postfix"
# $postfix_mynetworks = $network/$netmask
#
# You may have these components on separated servers or included on the same host
# Postfix (with Mysql support): include postfix::mysql
# Mysql: include mysql
# Apache+PHP+PostfixAdmin Web interface with Mysql support: include postfix::postfixadmin
#
# NOTE FOR RHEL5/Centos5
# For mysql support you must install the CENTOSPLUS version of postfix.
# See here for info: http://www.linuxmail.info/postfix-mysql-centos-5/
# (No time and real reason to automate this in Puppet)
#
class postfix::mysql inherits postfix {

    require postfix::params

    File["main.cf"] {
        content => template("postfix/main.cf-mysql"),
    }

    case $operatingsystem {
        debian: { include postfix::mysql::debian }
        ubuntu: { include postfix::mysql::debian }
        centos: { include postfix::mysql::centos }
        redhat: { include postfix::mysql::redhat }
        default: { }
    }

    file {
        "mysql_virtual_alias_maps.cf":
        mode => 644, owner => root, group => root,
        require => File["main.cf"],
        ensure => present,
        path => "${postfix::params::configdir}/mysql_virtual_alias_maps.cf",
        content => template("postfix/mysql_virtual_alias_maps.cf"),
    }

    file {
        "mysql_virtual_domains_maps.cf":
        mode => 644, owner => root, group => root,
        require => File["main.cf"],
        ensure => present,
        path => "${postfix::params::configdir}/mysql_virtual_domains_maps.cf",
        content => template("postfix/mysql_virtual_domains_maps.cf"),
    }

    file {
        "mysql_virtual_mailbox_maps.cf":
        mode => 644, owner => root, group => root,
        require => File["main.cf"],
        ensure => present,
        path => "${postfix::params::configdir}/mysql_virtual_mailbox_maps.cf",
        content => template("postfix/mysql_virtual_mailbox_maps.cf"),
    }

    file {
        "mysql_virtual_mailbox_limit_maps.cf":
        mode => 644, owner => root, group => root,
        require => File["main.cf"],
        ensure => present,
        path => "${postfix::params::configdir}/mysql_virtual_mailbox_limit_maps.cf",
        content => template("postfix/mysql_virtual_mailbox_limit_maps.cf"),
    }

    file {
        "mysql_virtual_relay_domains_maps.cf":
        mode => 644, owner => root, group => root,
        require => File["main.cf"],
        ensure => present,
        path => "${postfix::params::configdir}/ql_virtual_relay_domains_maps.cf",
        content => template("postfix/mysql_virtual_relay_domains_maps.cf"),
    }

    file {
        "/var/spool/vmail":
        mode => 770, owner => postfix, group => postfix,
        require => [ Package["postfix"] , File["main.cf"] ],
        ensure => directory,
    }

}
