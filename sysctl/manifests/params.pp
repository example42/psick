class sysctl::params {

# Basic settings
$configfile = $operatingsystem ? {
    default => "/etc/sysctl.conf",
}

}
