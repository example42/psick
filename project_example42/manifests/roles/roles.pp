# Examples of different roles 
# Customize, adapt and modify 


class minimal::xenmaster  {
	$my_role = "xenmaster"

	include minimal

	include xen
}


class hardened::vpn {
        $my_role = "vpn"
        $my_ipforward = "yes"

        include general
        include openvpn::example42
        include rip::example42
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

# Cobbler with some configuration settings. Review before using
	include cobbler::example42
# Vanilla Cobbler installation
#	include cobbler

	include tftp
##	include dhcpd::example42

#	include yumreposerver

}

class general::mail {
        $my_role = "mail"

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
#	$my_ipforward = "yes"
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

class general::monitor {
	$my_role = "monitor"

	include general

	include apache
	include nagios
	include cacti
	include mysql
}

# RedHat cluster suite 
class general::rhcs {
	$my_role = "rhcs"

	include general
	include xen
}

class general_syslog {
	$my_role = "syslog"
	include general

	$my_rsyslog_host = "localhost"
	$my_rsyslog_db = "Syslog"
	$my_rsyslog_user = "syslog"
	$my_rsyslog_password = "syslogpw"

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
        # include openvas
}


