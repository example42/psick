define mysql::user (
    $mysql_user,
    $mysql_password = '',
    $mysql_password_hash,
    $mysql_host = "localhost",
    $mysql_grant_filepath = "/root"
) {

    include mysql

    if (!defined(File[$mysql_grant_filepath])) {
        file {$mysql_grant_filepath:
            path => $mysql_grant_filepath,
            ensure => directory,
            owner => root,
            group => root,
            mode => 700;
        }
    }

    $mysql_grant_file = "mysqluser-$mysql_user-$mysql_host.sql"

    file {
        "$mysql_grant_file":
            mode => 600, owner => root, group => root,
            ensure => present,
            path => "$mysql_grant_filepath/$mysql_grant_file",
            content => template("mysql/user.erb"),
            replace => false;
    }

    exec {
        "mysqluser-$mysql_user-$mysql_host":
            command => "mysql --defaults-file=/root/.my.cnf -uroot < $mysql_grant_filepath/$mysql_grant_file",
            require => [ Service["mysql"], File['/root/.my.cnf'] ],
            subscribe => File["$mysql_grant_file"],
            path => [ "/usr/bin" , "/usr/sbin" ],
            refreshonly => true;
    }
}
