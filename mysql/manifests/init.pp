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


class mysql::cluster inherits mysql {
        package {
                "mysql-cluster":
                        ensure => present,
        }

        File["my.cnf"] {
                source  => "puppet://$server/mysql/my.cnf",
        }
}


class mysql::cluster::manager inherits mysql::cluster {

        Service["mysqld"] {
                enable    => "false",
                ensure    => "stopped",
        }

        file {
                "/var/lib/mysql-cluster/config.ini":
                        owner   => "root",
                        group   => "root",
                        mode    => "644",
                        require => Package["mysql-cluster"],
                        source  => "puppet://$server/mysql/config.ini",
        }

        service {
                "ndb_mgmd":
                enable    => "true",
                ensure    => "running",
        }
}

class mysql::cluster::datanode inherits mysql::cluster {

        File["my.cnf"] {
                source  => "puppet://$server/mysql/my.cnf-datanode",
        }

        Service["mysqld"] {
                enable    => "false",
                ensure    => "stopped",
        }

        service {
                "ndbd":
                enable    => "true",
                ensure    => "running",
        }
}

class mysql::cluster::sqlnode inherits mysql::cluster {

        File["my.cnf"] {
                source  => "puppet://$server/mysql/my.cnf-sqlnode",
        }
}

