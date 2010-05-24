class postfix::params  {

# Basic settings
    $packagename = $operatingsystem ? {
        default => "postfix",
    }

    $servicename = $operatingsystem ? {
        default => "postfix",
    }

    $configfile = $operatingsystem ? {
        default => "/etc/postfix/main.cf",
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

    $configdir = $operatingsystem ? {
        default => "/etc/postfix",
    }


# Location of postfix admin configuration file. Used in postfix::postfixadmin
    $postfixadminconf = $operatingsystem ? {
        debian  => "/var/www/postfixadmin/config.inc.php",
        ubuntu  => "/var/www/postfixadmin/config.inc.php",
        suse    => "/srv/www/postfixadmin/config.inc.php",
        default => "/var/www/html/postfixadmin/config.inc.php",
    }

}
