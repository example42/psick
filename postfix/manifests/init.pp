class postfix {

	package { postfix:
		name => $operatingsystem ? {
			default	=> "postfix",
			},
		ensure => present,
	}

	service { postfix:
		name => $operatingsystem ? {
                        default => "postfix",
                        },
		ensure => running,
		enable => true,
		hasrestart => true,
		hasstatus => true,
		require => Package["postfix"],
		subscribe => File["main.cf"],
	}

	file {	
             	"main.cf":
		mode => 644, owner => root, group => root,
		require => Package[postfix],
		ensure => present,
		path => $operatingsystem ?{
                       	default => "/etc/postfix/main.cf",
                        },
	}

}

class postfix::mysql inherits postfix {

	File["main.cf"] {
		content => template("postfix/main.cf-mysql"),
	}

	file {	
             	"mysql_virtual_alias_maps.cf":
		mode => 644, owner => root, group => root,
		require => File["main.cf"],
		ensure => present,
		path => $operatingsystem ?{
                       	default => "/etc/postfix/mysql_virtual_alias_maps.cf",
                        },
		content => template("postfix/mysql_virtual_alias_maps.cf"),
	}

	file {	
             	"mysql_virtual_domains_maps.cf":
		mode => 644, owner => root, group => root,
		require => File["main.cf"],
		ensure => present,
		path => $operatingsystem ?{
                       	default => "/etc/postfix/mysql_virtual_domains_maps.cf",
                        },
		content => template("postfix/mysql_virtual_domains_maps.cf"),
	}

	file {	
             	"mysql_virtual_mailbox_maps.cf":
		mode => 644, owner => root, group => root,
		require => File["main.cf"],
		ensure => present,
		path => $operatingsystem ?{
                       	default => "/etc/postfix/mysql_virtual_mailbox_maps.cf",
                        },
		content => template("postfix/mysql_virtual_mailbox_maps.cf"),
	}

	file {	
             	"mysql_virtual_mailbox_limit_maps.cf":
		mode => 644, owner => root, group => root,
		require => File["main.cf"],
		ensure => present,
		path => $operatingsystem ?{
                       	default => "/etc/postfix/mysql_virtual_mailbox_limit_maps.cf",
                        },
		content => template("postfix/mysql_virtual_mailbox_limit_maps.cf"),
	}

	file {	
             	"mysql_virtual_relay_domains_maps.cf":
		mode => 644, owner => root, group => root,
		require => File["main.cf"],
		ensure => present,
		path => $operatingsystem ?{
                       	default => "/etc/postfix/mysql_virtual_relay_domains_maps.cf",
                        },
		content => template("postfix/mysql_virtual_relay_domains_maps.cf"),
	}

	file {	
             	"/usr/local/virtual":
		mode => 770, owner => postfix, group => postfix,
		require => [ Package["postfix"] , File["main.cf"] ],
		ensure => directory,
	}

}

class postfix::mysql::postfixadmin inherits postfix::mysql {

        include apache

        php::module  {
                [ mysql, mbstring ]:
        }
	
	package { postfixadmin:
		name => $operatingsystem ? {
			default	=> "postfixadmin",
			},
		ensure => $update ?{
			yes	=> "latest",
			no	=> "present",
			default => "present",
			},
	}

        file {
                "postfixadmin.sql":
                mode => 640, owner => root, group => root,
                ensure => present,
                path => "/root/postfixadmin.sql",
                content => template("postfix/postfixadmin.sql"),
        }

        exec {
                "postfixadmin_dbsetup":
                        command => "mysql < /root/postfixadmin.sql",
                        require => File["postfixadmin.sql"],
                        onlyif  => "mysql -u <%= postfix_mysqluser %> -p <%= postfix_mysqlpassword %> dbname = <%= postfix_mysqldbname %>",
        }

# Postfixadmin config file configuration

 	$postfixadminconf = $operatingsystem ?{
                	default => "/var/www/postfixadmin/config.inc.php",
                }

	replaceline { 
		postfixadmin_configdb_host:
 		file => $postfixadminconf,
 		pattern => "database_host",
 		# replacement => "\x24CONF[\x27database_host\x27] = \x27$postfix_mysqlhost\x27; # Modified by Puppet";
 		replacement => "\$CONF['database_host'] = '$postfix_mysqlhost'; # Modified by Puppet";

		postfixadmin_configdb_dbname:
 		file => $postfixadminconf,
 		pattern => "database_name",
 		# replacement => "\x24CONF[\x27database_name\x27] = \x27$postfix_mysqldbname\x27; # Modified by Puppet";
 		replacement => "\$CONF['database_name'] = '$postfix_mysqldbname'; # Modified by Puppet";

                postfixadmin_configdb_user:
 		file => $postfixadminconf,
        	pattern => "database_user",
        	# replacement => "\x24CONF[\x27database_user\x27] = \x27$postfix_mysqluser\x27; # Modified by Puppet";
        	replacement => "\$CONF['database_user'] = '$postfix_mysqluser'; # Modified by Puppet";

                postfixadmin_configdb_password:
 		file => $postfixadminconf,
        	pattern => "database_password",
        	# replacement => "\x24CONF[\x27database_password\x27] = \x27$postfix_mysqlpassword\x27; # Modified by Puppet";
        	replacement => "\$CONF['database_password'] = '$postfix_mysqlpassword'; # Modified by Puppet";

                postfixadmin_configured:
 		file => $postfixadminconf,
        	pattern => "configured",
        	replacement => "\$CONF['configured'] = true; # Modified by Puppet";

        }

}

