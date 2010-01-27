# Define here your nodes
# (you can split the nodes definitions in different files to be managed by different people)
# You can override variables defined in the infrastructure tree
# Each node should inherit a zone node defined in infrastructure.pp
# A node can include single module-classes or a role class (useful when you have many hosts having the same function)
# Roles are defined in roles.pp

# Same example nodes 

## MANAGEMENT INFRASTRUCTURE HOSTS

node 'puppet.example42.com' inherits devel {
	include general
	
	include foreman
	include apache
	include puppet::dashboard
#	include puppet::foreman
#	include puppet::foreman::externalnodes

	include ssh::auth::keymaster
}


node 'syslog.example42.com' inherits devel {
        $my_rsyslog_host = "localhost"
        $my_rsyslog_db = "Syslog"
        $my_rsyslog_user = "syslog"
        $my_rsyslog_password = "syslogpw"

	include general

        include rsyslog::server::mysql
        include mysql
        include apache::php
        php::module { mysql: }
        php::module { gd: }
        mysql::grant { rsyslog:
                mysql_db         => $my_rsyslog_db,
                mysql_user       => $my_rsyslog_user,
                mysql_password   => $my_rsyslog_password,
        }

        netinstall { phplogcon:
                source_path      => "http://download.adiscon.com/phplogcon/",
                source_filename  => "phplogcon-2.7.2.tar.gz",
                destination_dir  => "/var/www/html",
        }
}


node 'monitor.example42.com' inherits devel {
	include general

	include monitor::server
}


node 'backup.example42.com' inherits devel {
	include general

	include backup::server
}


node 'cobbler.example42.com' inherits devel {
        $my_cobbler_server = "10.42.10.10"
        $my_tftp_server = "10.42.10.10"

        include general
	
# Cobbler with some configuration settings. Review before using
        include cobbler::example42

# Vanilla Cobbler installation
#       include cobbler

        include tftp
##      include dhcpd::example42
#       include yumreposerver
}


# Cacti Monitoring Server
node 'cacti.example42.com' inherits devel {
        $my_cacti_mysqluser = "cactiuser"
        $my_cacti_mysqlpassword = "example42"
        $my_cacti_mysqlhost = "localhost"
        $my_cacti_mysqldbname = "cacti"
        $my_mysql_passwd = "example42"

        include general
        include cacti
        include mysql
}



## TESTING HOSTS (Used for modules testing)

node 'test.example42.com' inherits devel {
	include general

	include backup::server
	include monitor::server
}

node 'debiantest.example42.com' inherits devel {
	include general
}

node 'opensusetest.example42.com' inherits devel {
	include general
}

node 'solaristest.example42.com' inherits devel {
	include minimal
#	include general
}




## PRODUCTION -  Internet Services


# Postfix+Mailscanner+Mailwatch Mail Server
node 'mail.example42.com' inherits prod {
        $my_postfix_mysqluser = "postfix"
        $my_postfix_mysqlpassword = "example42"
        $my_postfix_mysqlhost = "127.0.0.1"
        $my_postfix_mysqldbname = "postfix"
        $my_postfix_mynetworks = $my_network/$my_netmask

        $my_mailwatch_mysqluser = "mailwatch"
        $my_mailwatch_mysqlpassword = "exampl42"
        $my_mailwatch_mysqlhost = "127.0.0.1"
        $my_mailwatch_mysqldbname = "mailscanner"

        $my_mysql_passwd = "example42"

        include general
        include mysql::example42
        include dovecot::example42
        include clamav::epel
        include spamassassin
        # include mailscanner::example42
        # include mailscanner::postfix::mailwatch
        include postfix::example42
        include squirrelmail

}


# Generic Httpd server
node 'web01.example42.man' inherits prod {
        include general
	include apache
}


# Samba PDC - Ldap backend 
node 'dc.example42.com' inherits intranet {
        $ldap_master = "127.0.0.1"
        $ldap_slave  = "127.0.0.1"
        $ldap_basedn = "dc=example42,dc=com"
        $ldap_rootdn = "cn=Manager,dc=example42,dc=com"
        $ldap_rootpw = "{SSHA}example42tosha"
        $ldap_rootpwclear = "example42"
        $samba_sid        = "S-1-5-21-3645972101-772173552-949487278"
        $samba_workgroup  = "EXAMPLE42"
        $samba_pdc        = "dc.example42.com"
        $mysql_passwd     = "example42"

        include general

        include samba::ldap
}

# Security
node 'pentest.example42.com' inherits devel {
        include general

}

node 'gw.example42.com' inherits devel {
        $my_role = "gateway"
#       $my_ipforward = "yes"
        $my_ntop_password = "CHANGE:Password"
        augeasconfig { sysctl:
                file      => "/etc/sysctl.conf",
                parameter => "net.ipv4.ip_forward",
                value     => "1",
                lens      => "@Sysctl",
        }

        include general
        include apache
        include squid::transparent
        include ntop
        include sarg
}

node 'vpn.example42.com' inherits intranet {
        $my_role = "vpn"
        $my_ipforward = "yes"

        include general
        include openvpn::example42
        include rip::example42
}




# Bare metal
node 'xen01.example42.com' inherits intranet {
	include minimal::xenmaster
}

node 'xen02.example42.com' inherits intranet {
	include minimal::xenmaster
}



# Development 

node 'devel.example42.com' inherits devel {
	include general::devel
}

node 'build.example42.com' inherits devel {
	include general::build
}

node 'fileserver.example42.com' inherits remotebranch {
	include general
}
