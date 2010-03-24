define mysql::query (
	$mysql_db,
	$mysql_user = "root",
	$mysql_password = "",
	$mysql_host = "localhost",
	$mysql_query,
	$mysql_query_filepath = "/root"
	) {

        file {
                "mysqlquery-$mysql_user-$mysql_db.sql":
                mode => 600, owner => root, group => root,
                ensure => present,
                path => "$mysql_query_filepath/mysqlquery-$mysql_user-$mysql_db.sql",
                content => template("mysql/query.erb"),
		notify => Exec["mysqlquery-$mysql_user-$mysql_db"],
        }

        exec {
                "mysqlquery-$mysql_user-$mysql_db":
                        command => "mysql < $mysql_query_filepath/mysqlquery-$mysql_user-$mysql_db.sql",
                        require => Service["mysqld"],
			refreshonly => true,
			subscribe => File["mysqlquery-$mysql_user-$mysql_db.sql"],
	}

}

