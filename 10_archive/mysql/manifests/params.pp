class mysql::params  {

# Basic settings
    $packagename = $operatingsystem ? {
        default => "mysql",
    }

    $servicename = $operatingsystem ? {
        default => "mysqld",
    }

    $configfile = $operatingsystem ? {
        default => "/etc/my.cnf",
    }

    $configfile_mode = $operatingsystem ? {
        default => "644",
    }

    $configfile_owner = $operatingsystem ? {
        default => "root",
    }

    $configfile_group = $operatingsystem ? {
        default => "root",
    }

    $datadir = $operatingsystem ? {
        default => "/var/lib/mysql",
    }

}
