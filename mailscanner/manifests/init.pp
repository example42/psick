class mailscanner {
	$mailscannerver="MailScanner-4.69.9-2"
	$mailscannerfile="$mailscannerver.rpm.tar.gz"

        exec {
                "mailscanner_prerequisites":
                        command => $operatingsystem ? {
                        	default => "yum install -y wget tar gzip rpm-build binutils glibc-devel gcc make",
                        },
                        onlyif => "test ! -f /usr/src/$mailscannerfile",
        }

        exec {
                "mailscanner_download":
                        command => "cd /usr/src ; wget http://www.mailscanner.info/files/4/rpm/$mailscannerfile",
                        onlyif => "test ! -f /usr/src/$mailscannerfile",
                        require => Exec["mailscanner_prerequisites"],
        }

        exec {
                "mailscanner_extract":
                        command => "cd /usr/src ; tar -zxvf $mailscannerfile",
                        require => Exec["mailscanner_download"],
                        onlyif => "test ! -d /usr/src/$mailscannerver",
        }

        exec {
                "mailscanner_install":
                        command => "cd /usr/src/$mailscannerver ; ./install.sh",
                        require => [
				Exec["mailscanner_extract"],
				Package["spamassassin"],
				Package["clamav"]
				],
                        unless => "rpm -qi mailscanner",
        }

        service { mailscanner:
                name => "MailScanner",
                ensure => running,
                enable => true,
                hasrestart => true,
                hasstatus => true,
		require => Exec["mailscanner_install"],
        }

}


class mailscanner::postfix inherits mailscanner {

#        Service ["postfix"] { 
#                ensure => stopped,
#                enable => false,
#        }

#        File["main.cf"] {
#                source => "puppet://$servername/mailscanner/main.cf",
#        }

        file {
                "/etc/postfix/header_checks":
                mode => 644, owner => root, group => root,
                require => Package[postfix],
                ensure => present,
                source => "puppet://$servername/mailscanner/header_checks",
        }

        file {
                "MailScanner.conf":
                mode => 644, owner => root, group => root,
                require => Package[postfix],
                ensure => present,
                path   => "/etc/MailScanner/MailScanner.conf",
		source => "puppet://$servername/mailscanner/MailScanner.conf::postfix",
		require => Exec["mailscanner_install"],
        }

        file {
                "/var/spool/MailScanner/spamassassin":
                mode => 755, owner => postfix, group => postfix,
                require => Exec["mailscanner_install"],
                ensure => directory,
        }

        file {
                "/var/spool/MailScanner/quarantine":
                mode => 775, owner => postfix, group => apache,
                require => Exec["mailscanner_install"],
                ensure => directory,
        }
        file {
                "/var/spool/MailScanner/incoming":
                mode => 755, owner => postfix, group => postfix,
                require => Exec["mailscanner_install"],
                ensure => directory,
        }
}

class mailscanner::postfix::mailwatch inherits mailscanner::postfix {

	include apache::php

        package { mailwatch:
                name => $operatingsystem ? {
                        default => "mailwatch",
                        },
                ensure => present,
        }

        file {
                "/var/www/html/mailscanner/temp":
                mode => 755, owner => apache, group => apache,
                require => Package["mailwatch"],
                ensure => directory,
        }



        file {
                "mailwatch.sql":
                mode => 640, owner => root, group => root,
                ensure => present,
                path => "/root/mailwatch.sql",
                content => template("mailscanner/mailwatch.sql"),
        }


        exec {
                "mailwatch_usersetup":
			# Fast patch - needs fix
                        command => "mysql < /root/mailwatch.sql",
                        require => Package["mailwatch"],
                        onlyif  => "mysql -u <%= mailwatch_mysqluser %> -p <%= mailwatch_mysqlpassword %> dbname = <%= mailwatch_mysqldbname %>",
        }

        exec {
                "mailwatch_dbsetup":
			# Fast patch - needs fix
                        command => "mysql < /usr/share/doc/mailwatch-1.0.4/create.sql",
                        require => Exec["mailwatch_usersetup"],
                        onlyif  => "mysql -u <%= mailwatch_mysqluser %> -p <%= mailwatch_mysqlpassword %> dbname = <%= mailwatch_mysqldbname %> < SELECT COUNT() FROM USERS",
        }

# Mailwatch config file configuration

        $mailwatchconf = $operatingsystem ?{
                        default => "/usr/lib/MailScanner/MailScanner/CustomFunctions/MailWatch.pm",
                }

        ## fixedstring_replace_lines {
        replaceline { # Here works
                mailwatch_test:
                file => $mailwatchconf,
                pattern => "# Modify this",
                replacement => "### Test - Modified by Puppet";
                
		mailwatch_configdb_host:
                file => $mailwatchconf,
                pattern => "db_host) = ", # OK with replaceline
                # pattern => "my(\$db_host)",
                replacement => "my(\$db_host) = '$mailwatch_mysqlhost'; # Modified by Puppet";

                mailwatch_configdb_dbname:
                file => $mailwatchconf,
                pattern => "db_name) = ", # OK with replaceline
                replacement => "my(\$db_name) = '$mailwatch_mysqldbname'; # Modified by Puppet";

                mailwatch_configdb_user:
                file => $mailwatchconf,
                pattern => "db_user) = ", # OK with replaceline
                # pattern => "my(\$db_user)",
                replacement => "my(\$db_user) = '$mailwatch_mysqluser'; # Modified by Puppet";

                mailwatch_configdb_password:
                file => $mailwatchconf,
                pattern => "db_pass) = ", # OK with replaceline
                # pattern => "my(\$db_pass)",
                replacement => "my(\$db_pass) = '$mailwatch_mysqlpassword'; # Modified by Puppet";
        }


        $mailwatchphpconf = $operatingsystem ?{
                        default => "/var/www/html/mailscanner/conf.php",
                }


        # fixedstring_replace_lines {
        replaceline { # Works here
                mailwatchphp_configdb_host:
                file => $mailwatchphpconf,
                pattern => "define(DB_HOST",
                replacement => "define(DB_HOST, '$mailwatch_mysqlhost'); # Modified by Puppet";

                mailwatchphp_configdb_dbname:
                file => $mailwatchphpconf,
                pattern => "define(DB_NAME",
                replacement => "define(DB_NAME, '$mailwatch_mysqldbname'); # Modified by Puppet";

                mailwatchphp_configdb_user:
                file => $mailwatchphpconf,
                pattern => "define(DB_USER",
                replacement => "define(DB_USER, '$mailwatch_mysqluser'); # Modified by Puppet";

                mailwatchphp_configdb_password:
                file => $mailwatchphpconf,
                pattern => "define(DB_PASS",
                replacement => "define(DB_PASS, '$mailwatch_mysqlpassword'); # Modified by Puppet";
        }



}

