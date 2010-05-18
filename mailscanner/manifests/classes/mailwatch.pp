# Class: mailscanner::mailwatch
#
# This class installs and configures the web frontend Mailwatch for MailScanner
# MailWatch homepage: http://mailwatch.sourceforge.net/
#
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
#
class mailscanner::mailwatch inherits mailscanner {

# Some prerequisites
    require mailscanner::params
    require mailscanner::postfix
    require apache
    require mysql
    require apache::params
    require clamav::params

# Quick fix to use these variables in the template
$apache_user = "${apache::params::username}"
$clamav_user = "${clamav::params::username}"
$mailscanner_customfunctionsdir = "${mailscanner::params::custom_functions_dir}"

File["MailScanner.conf"] {
    content => template("mailscanner/mailwatch/MailScanner.conf.erb"),
}

    # Already included in postfix::postfixadmin.
    # Uncomment if you don't use postfix::postfixadmin.
    # php::module  { [ mysql, mbstring ]: }


# Download sources from official site

    netinstall { "mailwatch":
        url         => "${mailscanner::params::mailwatch_source_url}",
        extracted_dir   => "${mailscanner::params::mailwatch_extracted_dir}",
        postextract_command => "cp -a mailscanner ${mailscanner::params::mailwatch_webdir}",
        destination_dir => "${mailscanner::params::mailwatch_destination_dir}",
        require => $operatingsystem ? {
            ubuntu  => Package["mailscanner"],
            debian  => Package["mailscanner"],
            default => Exec["MailScannerBuildAndInstall"],
            },
    }


    file {
        "${mailscanner::params::mailwatch_webdir}/temp":
        mode => 755, owner => "${apache::params::username}", group => "${apache::params::username}",
        require => Netinstall["mailwatch"],
        ensure => directory,
    }

    mysql::grant { mailscanner:
        mysql_db    => $mailscanner_mysqldbname,
        mysql_user    => $mailscanner_mysqluser,
        mysql_password    => $mailscanner_mysqlpassword,
        mysql_host    => $mailscanner_mysqlhost,
        mysql_privileges => "ALL",
        require     => Service["mysql"],
    }

# The following grant is necessary to load into database the GeoIP data.
# Note that this is not very secure - Better to comment out if other databases are hosted on your Mysql server
    mysql::query { mailwatch_filegrant:
        mysql_db    => $mailscanner_mysqldbname,
        mysql_query     => "GRANT FILE ON *.* to $mailscanner_mysqluser@$mailscanner_mysqlhost ;",
        require     => Exec["mailwatch_dbsetup"],
    }


    exec {
        "mailwatch_dbsetup":
            command => "mysql < ${mailscanner::params::mailwatch_destination_dir}/${mailscanner::params::mailwatch_extracted_dir}/create.sql",
            require => [ Service["mysql"] , Netinstall["mailwatch"] ],
            unless  => "find /var/lib/mysql/mailscanner | grep user",
    }

    mysql::query { mailwatch_admin:
        mysql_db    => $mailscanner_mysqldbname,
        mysql_user      => $mailscanner_mysqluser,
        mysql_password  => $mailscanner_mysqlpassword,
        mysql_host      => $mailscanner_mysqlhost,
        mysql_query     => "INSERT INTO users (username,password,fullname,type) VALUES ('$mailscanner_adminuser',md5('$mailscanner_adminpassword'),'MailScanner Admin','A');",
        require     => Exec["mailwatch_dbsetup"],
    }

    exec {
        "mailwatchpm_copy":
            command => "cp -a MailWatch.pm ${mailscanner::params::custom_functions_dir}/",
            require => Netinstall["mailwatch"],
            unless  => "ls ${mailscanner::params::custom_functions_dir}/MailWatch.pm", 
            cwd    => "${mailscanner::params::mailwatch_destination_dir}/${mailscanner::params::mailwatch_extracted_dir}",
    }

    exec {
        "sqlblackwhitelist_copy":
            command => "cp -a SQLBlackWhiteList.pm ${mailscanner::params::custom_functions_dir}/",
            require => Netinstall["mailwatch"],
            unless  => "ls ${mailscanner::params::custom_functions_dir}/SQLBlackWhiteList.pm", 
            cwd    => "${mailscanner::params::mailwatch_destination_dir}/${mailscanner::params::mailwatch_extracted_dir}",
    }

    exec {
        "mailwatchphpconf_copy":
            command => "cp ${mailscanner::params::mailwatch_webdir}/conf.php.example ${mailscanner::params::mailwatch_webdir}/conf.php",
            require => Netinstall["mailwatch"],
            unless  => "ls ${mailscanner::params::mailwatchconf}", 
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
#    mailscanner::conf { "Always Looked Up Last": value => "&MailWatchLogging" }
#    mailscanner::conf { "Detailed Spam Report": value => "yes" }
#    mailscanner::conf { "Quarantine Whole Message": value => "yes" }
#    mailscanner::conf { "Quarantine Whole Message As Queue Files": value => "no" }
#    mailscanner::conf { "Include Scores In SpamAssassin Report": value => "yes" }
#    mailscanner::conf { "Quarantine User": value => "root" }
#    mailscanner::conf { "Quarantine Group": value => "apache" }
#    mailscanner::conf { "Quarantine Permissions": value => "0660" }
    
#    mailscanner::conf { "Is Definitely Not Spam": value => "&SQLWhitelist" }
#    mailscanner::conf { "Is Definitely Spam": value => "&SQLBlacklist" }
    
#    mailscanner::conf { "Spam Actions": value => "store" }
#       mailscanner::conf { "High Scoring Spam Actions": value => "store" }

# FixUps for Quarantine release. See: http://mailwatch.sourceforge.net/doku.php?id=mailwatch:faq
#    mailscanner::conf { "Filename Rules": value => "%etc-dir%/filename.rules" }
#    mailscanner::conf { "Filetype Rules": value => "%etc-dir%/filetype.rules" }
#    mailscanner::conf { "Dangerous Content Scanning": value => "%rules-dir%/content.scanning.rules" }
#    mailscanner::conf { "Is Definitely Not Spam": value => "%rules-dir%/spam.whitelist.rules" } # Note that this is already defined with value &SQLWhitelist - Leave it and add 127.0.0.1 to whitelist via the webinterface 

    file {
        "filetype.rules":
        mode => 644, owner => root, group => root,
        require => Netinstall["mailwatch"],
        content => template("mailscanner/mailwatch/filetype.rules"),
        notify  => Service["mailscanner"],
        path    => "/etc/MailScanner/filetype.rules",
    }

    file {
        "filename.rules":
        mode => 644, owner => root, group => root,
        require => Netinstall["mailwatch"],
        content => template("mailscanner/mailwatch/filename.rules"),
        notify  => Service["mailscanner"],
        path    => "/etc/MailScanner/filename.rules",
    }

    file {
        "filetype.rules.allowall.conf":
        mode => 644, owner => root, group => root,
        require => Netinstall["mailwatch"],
        content => template("mailscanner/mailwatch/filetype.rules.allowall.conf"),
        notify  => Service["mailscanner"],
        path    => "/etc/MailScanner/filetype.rules.allowall.conf",
    }

    file {
        "filename.rules.allowall.conf":
        mode => 644, owner => root, group => root,
        require => Netinstall["mailwatch"],
        content => template("mailscanner/mailwatch/filename.rules.allowall.conf"),
        notify  => Service["mailscanner"],
        path    => "/etc/MailScanner/filename.rules.allowall.conf",
    }

    file {
        "content.scanning.rules":
        mode => 644, owner => root, group => root,
        require => Netinstall["mailwatch"],
        content => template("mailscanner/mailwatch/content.scanning.rules"),
        notify  => Service["mailscanner"],
        path    => "/etc/MailScanner/rules/content.scanning.rules",
    }

    file {
        "spam.whitelist.rules":
        mode => 644, owner => root, group => root,
        require => Netinstall["mailwatch"],
        content => template("mailscanner/mailwatch/spam.whitelist.rules"),
        notify  => Service["mailscanner"],
        path    => "/etc/MailScanner/rules/spam.whitelist.rules",
    }

}
