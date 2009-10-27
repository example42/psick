class mysql {
      
        package {
                "mysql-server":
                        ensure => present,
        }

        file {
                "my.cnf":
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        require => Package["mysql-server"],
                        path    => $operatingsystem ?{
                                default => "/etc/my.cnf",
                                },
                        source  => "puppet://$server/mysql/my.cnf",
        }

        service {
                "mysqld":
                enable    => "true",
                ensure    => "running",
                require => Package["mysql-server"],
        }
}

