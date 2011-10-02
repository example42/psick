define mysql::grant (
    $mysql_db,
    $mysql_user,
    $mysql_password,
    $mysql_privileges = "ALL",
    $mysql_host = "localhost",
    $mysql_grant_filepath = "/root"
    ) {

    require mysql

    if (!defined(File[$mysql_grant_filepath])) {
        file { "$mysql_grant_filepath":
            path   => $mysql_grant_filepath,
            ensure => directory,
            owner  => root,
            group  => root,
            mode   => 700,
        }
    }

    if ($mysql_db == '*') {
        $mysql_grant_file = "mysqlgrant-$mysql_user-$mysql_host-all.sql"
    } else {
        $mysql_grant_file = "mysqlgrant-$mysql_user-$mysql_host-$mysql_db.sql"
    }

    file { "$mysql_grant_file":
        mode => 600, owner => root, group => root,
        ensure => present,
        path => "$mysql_grant_filepath/$mysql_grant_file",
        content => template("mysql/grant.erb"),
        replace => false;
    }

    exec { "mysqlgrant-$mysql_user-$mysql_host-$mysql_db":
        command => $mysql::params::root_password ? {
            ""      => "mysql -uroot < $mysql_grant_filepath/$mysql_grant_file",
            default => "mysql --defaults-file=/root/.my.cnf -uroot < $mysql_grant_filepath/$mysql_grant_file",
        },
        require => $mysql_user ? { 
            root    => Service["mysql"],
            default => Service["mysql"],
            # default => [ Service["mysql"] , Exec["mysqluser-$mysql_user-$mysql_host"] ],
        },
        subscribe => File["$mysql_grant_file"],
        path => [ "/usr/bin" , "/usr/sbin" ],
        refreshonly => true;
    }

}

