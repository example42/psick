class cacti {

    include apache::php
    include mysql 

    package {
        "cacti":
        name => $operatingsystem ? {
            default => "cacti",
            },
        ensure => present;

        "net-snmp-utils":
        name => $operatingsystem ? {
            default => "net-snmp-utils",
            },
        ensure => present,
    }

    file {
        "cacti.conf":
            owner   => $operatingsystem ?{
                default => "root",
                },
            group   => $operatingsystem ?{
                default => "root",
                },
            mode    => 644,
            require => Package["apache"],
            ensure  => present,
            path    => $operatingsystem ?{
                default => "/etc/httpd/conf.d/cacti.conf",
                },
    }


    file {
        "cacti.sql":
        mode => 640, owner => root, group => root,
        ensure => present,
        path => "/root/cacti.sql",
        content => template("cacti/cacti.sql"),
    }

    exec {
        "cacti_dbsetup":
            command => "mysql < /root/cacti.sql",
            require => File["cacti.sql"],
            onlyif  => "mysql -u <%= cacti_mysqluser %> -p <%= cacti_mysqlpassword %> dbname = <%= cacti_mysqldbname %>",
    }

# Cacti config file configuration

    $cacticonf = $operatingsystem ?{
            default => "/etc/cacti/db.php",
        }

    replaceline {
        cacti_configdb_host:
        file => $cacticonf,
        pattern => "database_hostname",
        replacement => "\$database_hostname = '$cacti_mysqlhost'; # Modified by Puppet";

        cacti_configdb_dbname:
        file => $cacticonf,
        pattern => "database_default",
        replacement => "\$database_default = '$cacti_mysqldbname'; # Modified by Puppet";

        cacti_configdb_user:
        file => $cacticonf,
        pattern => "database_user",
        replacement => "\$database_username = '$cacti_mysqluser'; # Modified by Puppet";

        cacti_configdb_password:
        file => $cacticonf,
        pattern => "database_password",
        replacement => "\$database_password = '$cacti_mysqlpassword'; # Modified by Puppet";

    }

}
