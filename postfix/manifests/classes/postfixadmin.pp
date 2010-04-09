# Class: postfix::postfixadmin
#
# This class installs and configures Postfix Admin Web Interface to manage postfix with Mysql backend
# Postfix Admin homepage: http://sourceforge.net/projects/postfixadmin/

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



class postfix::postfixadmin {

        $webroot =  $operatingsystem ?{
                        debian  => "/var/www",
                        ubuntu  => "/var/www",
                        suse    => "/srv/www",
                        default => "/var/www/html",
                }

        require apache
        php::module  { [ mysql, mbstring, imap ]: }

        netinstall { postfixadmin:
                url             => "http://downloads.sourceforge.net/project/postfixadmin/postfixadmin/postfixadmin_2.3.tar.gz",
                extracted_dir   => "postfixadmin-2.3",
                postextract_command => "ln -s postfixadmin-2.3 ../postfixadmin",
                destination_dir => $webroot,
                require => Package["apache"],
        }

        mysql::grant { postfixadmin:
                mysql_db	=> $postfix_mysqldbname,
                mysql_user	=> $postfix_mysqluser,
                mysql_password	=> $postfix_mysqlpassword,
                mysql_host	=> $postfix_mysqlhost,
                mysql_privileges => "ALL",
        }


# Postfixadmin config file configuration

        $postfixadminconf = $operatingsystem ?{
                        debian  => "/var/www/postfixadmin/config.inc.php",
       	                ubuntu  => "/var/www/postfixadmin/config.inc.php",
               	        suse    => "/srv/www/postfixadmin/config.inc.php",
                       	default => "/var/www/html/postfixadmin/config.inc.php",
        }

        file { "$postfixadminconf":
                ensure => present,
                require => Netinstall["postfixadmin"],
        }

        config {
                postfixadmin_configdb_host:
                file => $postfixadminconf,
                pattern => "database_host",
                engine => "replaceline",
                require => File["$postfixadminconf"],
		line => "\$CONF['database_host'] = '$postfix_mysqlhost'; # Modified by Puppet";

                postfixadmin_configdb_dbname:
                file => $postfixadminconf,
                pattern => "database_name",
                engine => "replaceline",
                require => File["$postfixadminconf"],
                line => "\$CONF['database_name'] = '$postfix_mysqldbname'; # Modified by Puppet";

                postfixadmin_configdb_user:
                file => $postfixadminconf,
                pattern => "database_user",
                engine => "replaceline",
                require => File["$postfixadminconf"],
                line => "\$CONF['database_user'] = '$postfix_mysqluser'; # Modified by Puppet";

                postfixadmin_configdb_password:
                file => $postfixadminconf,
                pattern => "database_password",
                engine => "replaceline",
                require => File["$postfixadminconf"],
                line => "\$CONF['database_password'] = '$postfix_mysqlpassword'; # Modified by Puppet";

                postfixadmin_configured:
                file => $postfixadminconf,
                pattern => "configured",
                engine => "replaceline",
                require => File["$postfixadminconf"],
                line => "\$CONF['configured'] = true; # Modified by Puppet";

        }

}

