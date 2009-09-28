# Roles Definition
# Customize roles to your needs: a good thing is to have a role (and only one) for each host
# Same role can be used for different hosts: webservers, proxies, mail servers, cluster nodes..

# Definition of generic classes, that include the modules that have to be added to each host

class minimal {

	# NETWORKING
	# /etc/hosts . Here needed for local use
	include hosts::example42

	# You may prefer to avoid definiting IP settings via puppet
	# include network
	# DNS resolver
	include resolver
	
	# PUPPET client settings
	include puppet

	# PACKAGE MANAGEMENT
	# Package management can be done with "repo" OR "yum" class
	# Both provide ready to use public repos for Centos 5
	# Customization is needed if you use different distros or repo sources

	# repo class uses simple static repo files (you may enhance with templating)
	# Include base repo or alternatively the epel OR rpmforce extra repos
	# include repo
	include repo::epel
	$extrarepo = epel # Preferred repository (used in nrpe module)
	# include repo::rpmforge

	# As ALTERNATIVE you can use the imported yum class (Copyright (C) 2007 admin@immerda.ch)
	# It uses the yumrepo type (somehow more enginereed but more flexible)
	# Default settings include various public repos (some are not enabled by default)
	# include yum

}

class general {

	# This general class imports all minimal settings.
	# You may decide to define different "general" classes and define here site-wide logic
	include minimal 
	
	# Iptables settings.
	
	# include iptables
	include iptables::disable
	

	# Sysctl management. Define "$my_ipforward = yes" for activating IP forwarding
	# Default  sysctl::hardened settings could not be what you want.
	include sysctl::hardened

	
	include nrpe
	include snmpd
	include ntp
#	include clock
	include cron
	include syslog
	include rootmail

	# (LOCAL) USERS MANAGEMENT. If wanted.
	# BE WARNED: Here is defined a sample example42 user with password example42 (!)
	include users::example42

	# Hardening in compliance with EAL4 guidelines
	# Review and test the changes applied
	# CHANGE admin user password!
	# This is cross class that includes other hardening specific sub classes
	include hardening::eal4

	# SELINUX management. Include selinux::disabled , selinux::permissive or selinux::enforcing
	include selinux::permissive

	# Some extras 
	include func
#	include aide
#	include psad
#	include rsync
#	include logrotate

}


class general::test {
	$my_role = "test"
	$my_ipforward = "no"

	include general
#	include phpsyslogng

	include certmaster::enable
	include func::enable
	include symbolic::enable
}


# Examples of different roles 
# Customize, adapt and modify 

class minimal::xenmaster  {
	$my_role = "xenmaster"

	include minimal

	include xen
}

class general::phpdevel {
	$my_role = "phpdevel"

	include general

	include apache
	include php
	include mysql
	include phpmyadmin
	include eclipse-php
}

class general::provisioner {
	$my_role = "provisioner"
	
	include general

	include cobbler::example42
	include tftp
##	include dhcpd::example42
 	include puppet::master

#	include yumreposerver

}

class general::mail inherits general {
        $my_role = "mail"

        include general
        include mysql::example42
        include bind::example42
        include dovecot::example42
        include clamav::epel
        include spamassassin
        include mailscanner::example42
        # include mailscanner::postfix::mailwatch
        include postfix::example42
        include squirrelmail
}

class general::file {
        $my_role = "file"

	include general
        include samba::example42
        include bind::example42
        include dhcpd::example42
}

class general::vpn {
        $my_role = "vpn"
	$my_ipforward = "yes"

	include general
        include openvpn::example42
        include rip::example42
}


class general::langateway  {
	$my_role = "gateway"
	$my_ipforward = "yes"
	$my_ntop_password = "CHANGE:Password"

	include general
	include apache
	include squid::transparent
	include ntop
	include sarg
}

class general::monitor inherits general {
	$my_role = "monitor"

	include apache
	include nagios
	include cacti
	include mysql
}

# RedHat cluster suite 
class general::rhcs inherits general {
	$my_role = "rhcs"

	include xen
}

class general::syslog inherits general {
	$my_role = "syslog"
#	include phpsyslogng
}


# Mysql Cluster 

class general::mysqlmanager inherits general {
	$my_role ="mysqlmanager"

        include repo::testing
        include mysql::cluster::manager
}

class general::sqlnode inherits general {
	$my_role ="sqlnode"

        include repo::testing
        include mysql::cluster::sqlnode
}

class general::datanode inherits general {
	$my_role ="datanode"

        include repo::testing
        include mysql::cluster::datanode
}


# Possible roles (to make and extend)

class general::ids inherits general {
	$my_role = "ids"

        # include snort::acid
        # include tripwire
}

class general::scan inherits general {
	$my_role = "scan"

        include general_host

        # include nmap
        # include nessus
        # include metaspoit
}


