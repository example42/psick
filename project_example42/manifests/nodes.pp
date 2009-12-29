# Define here your nodes
# (you can split the nodes definitions in different files to be managed by different people)
# You can override variables defined in the infrastructure tree
# Each node should inherit a zone node defined in infrastructure.pp
# A anode can include single module-classes or a role class
# Roles are defined in roles.pp

# Same example nodes 

# Puppet Master
node 'puppet.example42.com' inherits devel {
	include foreman
	include apache
	include minimal
	include general
	include puppet::dashboard
#	include puppet::foreman
#	include puppet::foreman::externalnodes
}

## Testing hosts (Used for modules testing)

node 'test.example42.com' inherits devel {
	include minimal
	include general
}

node 'debiantest.example42.com' inherits devel {
	include minimal
	include general
}

node 'opensusetest.example42.com' inherits devel {
	include minimal
	include general
}

node 'solaristest.example42.com' inherits devel {
	include minimal
#	include general
}


# Cobbler Server 
node 'cobbler.example42.com' inherits devel {
	$my_cobbler_server = "10.42.10.10"
	$my_tftp_server = "10.42.10.10"

	include general::provisioner
}

# Central Syslog Server
node 'syslog.example42.com' inherits devel {
	include general
	include general_syslog
}

# Cacti Monitoring Server
node 'cacti.example42.com' inherits intranet {
        $my_cacti_mysqluser = "cactiuser"
        $my_cacti_mysqlpassword = "example42"
        $my_cacti_mysqlhost = "localhost"
        $my_cacti_mysqldbname = "cacti"
        $my_mysql_passwd = "example42"
        include general::monitor
}



# Internet Services


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

        include general::mail
}


node 'web01.example42.man' inherits prod {
        $my_apache_namevirtualhost = "10.42.10.12"
        $my_mysql_passwd = "example42"
        $my_postfix_mynetworks = $my_network/$my_netmask
        
	include general::webhosting
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

node 'devel.example42.com' inherits devel {
	include general::devel
}

node 'build.example42.com' inherits devel {
	include general::build
}

node 'fileserver.example42.com' inherits remotebranch {
	include general
}
