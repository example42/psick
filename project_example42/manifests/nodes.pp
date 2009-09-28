# Define here your nodes
# You can override variables defined in the infrastructure tree
# Each node should inherit and environment node and include a role class

# Sample nodes with sample roles.

# Management Infrastructure
node 'kick.example42.com' inherits intranet {
	$my_cobbler_server = "10.42.10.10"
	$my_tftp_server = "10.42.10.10"

	include general::provisioner
}

node 'syslog.example42.com' inherits intranet {
	include general::syslog
}

node 'monitor.example42.com' inherits intranet {
        $my_cacti_mysqluser = "cactiuser"
        $my_cacti_mysqlpassword = "example42"
        $my_cacti_mysqlhost = "localhost"
        $my_cacti_mysqldbname = "cacti"
        $my_mysql_passwd = "example42
"
        include general::monitor
}



# Services

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

        include general::mail
}

node 'web01.example42.man' inherits prod {
        $my_apache_namevirtualhost = "10.42.10.12"
        $my_mysql_passwd = "example42"
        $my_postfix_mynetworks = $my_network/$my_netmask
        
	include general::webhosting
}

node 'dc.example42.com' inherits intranet {
        $ldap_master = "127.0.0.1"
        $ldap_slave  = "127.0.0.1"
        $ldap_basedn = "dc=example42,dc=com"
        $ldap_rootdn = "cn=Manager,dc=example42,dc=com"
        $ldap_rootpw = "{SSHA}example42tosha"
        $ldap_rootpwclear = "example42"
        $samba_sid        = "S-1-5-21-3645972101-772173552-949487278"
        $samba_workgroup  = "INTRANET"
        $samba_pdc        = "dc.example42.com"
        $mysql_passwd     = "example42"

        include general::file
}




# Security
node 'pentester.example42.com' inherits intranet {
	include general::scan
}

node 'lanfirewall.example42.com' inherits intranet {
	include general::gateway
}

node 'vpn.example42.com' inherits intranet {
	include general::vpn
}




# Bare metal
node 'xen01.example42.com' inherits intranet {
	include minimal::xenmaster
}

node 'xen02.example42.com' inherits intranet {
	include minimal::xenmaster
}



# Development 
node 'test.example42.com' inherits intranet {
	$my_local_network = "10.42.10.0/24"
	$my_default_gateway = "10.42.10.0/24"
	include general::test
}

node 'devel.example42.com' inherits intranet {
	include general::devel
}

node 'build.example42.com' inherits intranet {
	include general::build
}

node 'fileserver.example42.com' inherits remotebranch {
	include general
}
