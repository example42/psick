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
