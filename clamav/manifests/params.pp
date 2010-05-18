class clamav::params  {

# Basic settings
$packagename = $operatingsystem ? {
    default => "clamav",
}

$packagename_data = $operatingsystem ? {
    default => "clamav-data",
}

$packagename_freshclam = $operatingsystem ? {
    redhat  => "clamav-update",
    centos  => "clamav-update",
    default => "clamav-freshclam",
}

$packagename_daemon = $operatingsystem ? {
    redhat  => "clamav-server",
    centos  => "clamav-server",
    default => "clamav-daemon",
}

$username = $operatingsystem ? {
    redhat  => "clamd",
    centos  => "clamd",
    default => "clamav",
}

}

