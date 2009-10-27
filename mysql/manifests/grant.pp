define mysql::grant (
	$mysql_db,
	$mysql_user,
	$mysql_password,
	$mysql_privileges = "ALL",
	$mysql_clienthost = "localhost"
	) {

        file {
                "mysqluser-$mysql_user-$mysql_db.sql":
                mode => 600, owner => root, group => root,
                ensure => present,
                path => "/root/mysqluser-$mysql_user-$mysql_db.sql",
                content => template("mysql/grant.erb"),
		notify => Exec["mysqlgrant-$mysql_user-$mysql_db"],
        }

        exec {
                "mysqlgrant-$mysql_user-$mysql_db":
                        command => "mysql < /root/mysqluser-$mysql_user-$mysql_db.sql",
                        require => Service["mysqld"],
                        onlyif  => "mysql -u <%= mysql_user %> -p <%= mysql_password %> dbname = <%= mysql_db %>",
	}

}

