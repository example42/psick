# Class: mailscanner::mailwatch
#
# This class installs and configures the web frontend Mailwatch for MailScanner
# MailWatch homepage: http://mailwatch.sourceforge.net/

# PREREQUISITES
# You need to set the following variables (here with example values)
# $mailscanner_mysqluser = "mailscanner"
# $mailscanner_mysqlpassword = "example42"
# $mailscanner_mysqlhost = "127.0.0.1"
# $mailscanner_mysqldbname = "mailscanner"
#
# This class requires Example42 apache module (just for the php::module define) and Example42 common module (for the netinstall and config defines)
# NOTE: Due to molteplicy of relations, this class is tuned and tested for a 
# Postfix + MailScanner + MailWatch installation on RedHat/Centos 5.
# You may need to fix and refine things for proper work under different setups.
#
# For sake of simplicity, this downloads and installs version 1.0.5 (Released 2010-02-03)
# Just change the version number for updates
# Or use the package type to install a custom package for your OS.


class mailscanner::mailwatch inherits mailscanner::base {

File["MailScanner.conf"] {
	content => template("mailscanner/mailwatch/MailScanner.conf.erb"),
}

# Some variables used in this class
$mailwatch_extracted_dir = "mailwatch-1.0.5"
$mailwatch_source_filename = "mailwatch-1.0.5.tar.gz"
$mailwatch_source_path = "http://downloads.sourceforge.net/project/mailwatch/mailwatch/1.0.5/mailwatch-1.0.5.tar.gz?use_mirror=surfnet"
$mailwatch_destination_dir = $operatingsystem ?{
	default => "/usr/src/",
}
$mailwatch_webdir = $operatingsystem ?{
	debian  => "/var/www/mailscanner",
	ubuntu  => "/var/www/mailscanner",
	suse    => "/srv/www/mailscanner",
	default => "/var/www/html/mailscanner",
}
$mailwatchconf = "$mailwatch_webdir/conf.php"
$mailscanner_custom_functions_dir = $operatingsystem ?{
	default => "/usr/lib/MailScanner/MailScanner/CustomFunctions",
}


# Some prerequisites
	include mailscanner::postfix
        include apache
        include mysql

	# Already included in postfix::postfixadmin.
	# Uncomment if you don't use postfix::postfixadmin.
        # php::module  { [ mysql, mbstring ]: }


# Download sources from official site
        netinstall { mailwatch:
                source_path     => $mailwatch_source_path,
                source_filename => $mailwatch_source_filename,
                extracted_dir   => $mailwatch_extracted_dir,
                postextract_command => "cp -a mailscanner $mailwatch_webdir",
		destination_dir => $mailwatch_destination_dir,
        }


        file {
                "$mailwatch_webdir/temp":
                mode => 755, owner => apache, group => apache,
                require => Netinstall["mailwatch"],
                ensure => directory,
        }

        mysql::grant { mailscanner:
                mysql_db	=> $mailscanner_mysqldbname,
                mysql_user	=> $mailscanner_mysqluser,
                mysql_password	=> $mailscanner_mysqlpassword,
                mysql_host	=> $mailscanner_mysqlhost,
                mysql_privileges => "ALL",
        }

        exec {
                "mailwatch_dbsetup":
                        command => "mysql < $mailwatch_destination_dir/$mailwatch_extracted_dir/create.sql",
                        require => Service["mysqld"],
                        onlyif  => "mysql -u <%= mailscanner_mysqluser %> -p <%= mailscanner_mysqlpassword %> dbname = <%= mailscanner_mysqldbname %> < SELECT COUNT() FROM USERS",
        }

        mysql::query { mailwatch_admin:
                mysql_db        => $mailscanner_mysqldbname,
                mysql_user      => $mailscanner_mysqluser,
                mysql_password  => $mailscanner_mysqlpassword,
                mysql_host      => $mailscanner_mysqlhost,
                mysql_query     => "INSERT INTO users (username,password,fullname,type) VALUES ('$mailscanner_adminuser',md5('$mailscanner_adminpassword'),'MailScanner Admin','A');",
		require         => Exec["mailwatch_dbsetup"],
        }

        exec {
                "mailwatchpm_copy":
                        command => "cp -a MailWatch.pm $mailscanner_custom_functions_dir/",
                        require => Netinstall["mailwatch"],
                        unless  => "ls $mailscanner_custom_functions_dir/MailWatch.pm", 
        		cwd	=> "$mailwatch_destination_dir/$mailwatch_extracted_dir",
	}

        exec {
                "sqlblackwhitelist_copy":
                        command => "cp -a SQLBlackWhiteList.pm $mailscanner_custom_functions_dir/",
                        require => Netinstall["mailwatch"],
                        unless  => "ls $mailscanner_custom_functions_dir/SQLBlackWhiteList.pm", 
        		cwd	=> "$mailwatch_destination_dir/$mailwatch_extracted_dir",
	}

        exec {
                "mailwatchphpconf_copy":
                        command => "cp $mailwatch_webdir/conf.php.example $mailwatch_webdir/conf.php",
                        require => Netinstall["mailwatch"],
                        unless  => "ls $mailwatchconf", 
        }

# Configuration of mailwatch conf.php file
        mailwatch::conf { "DB_HOST": value => $mailscanner_mysqlhost }
        mailwatch::conf { "DB_USER": value => $mailscanner_mysqluser }
        mailwatch::conf { "DB_PASS": value => $mailscanner_mysqlpassword }
        mailwatch::conf { "DB_NAME": value => $mailscanner_mysqldbname }

# Configuration of mailwatch.pm file
        mailwatch::pmconf { "db_host": value => $mailscanner_mysqlhost }
        mailwatch::pmconf { "db_user": value => $mailscanner_mysqluser }
        mailwatch::pmconf { "db_pass": value => $mailscanner_mysqlpassword }
        mailwatch::pmconf { "db_name": value => $mailscanner_mysqldbname }

# Configuration of SQLBlackWhiteList.pm
        mailwatch::pmconfsql { "db_host": value => $mailscanner_mysqlhost }
        mailwatch::pmconfsql { "db_user": value => $mailscanner_mysqluser }
        mailwatch::pmconfsql { "db_pass": value => $mailscanner_mysqlpassword }
        mailwatch::pmconfsql { "db_name": value => $mailscanner_mysqldbname }

# Configuration of MailScanner.conf 
# Here are the parameters needed for Mailwatch integration
# We use directly a template to manage MailScanner.conf
#        mailscanner::conf { "Always Looked Up Last": value => "&MailWatchLogging" }
#        mailscanner::conf { "Detailed Spam Report": value => "yes" }
#        mailscanner::conf { "Quarantine Whole Message": value => "yes" }
#        mailscanner::conf { "Quarantine Whole Message As Queue Files": value => "no" }
#        mailscanner::conf { "Include Scores In SpamAssassin Report": value => "yes" }
#        mailscanner::conf { "Quarantine User": value => "root" }
#        mailscanner::conf { "Quarantine Group": value => "apache" }
#        mailscanner::conf { "Quarantine Permissions": value => "0660" }
        
#	mailscanner::conf { "Is Definitely Not Spam": value => "&SQLWhitelist" }
#	mailscanner::conf { "Is Definitely Spam": value => "&SQLWhitelist" }
        
#	mailscanner::conf { "Spam Actions": value => "store" }
#       mailscanner::conf { "High Scoring Spam Actions": value => "store" }

}
