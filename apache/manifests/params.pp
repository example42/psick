class apache::params  {

# Basic settings
$packagename = $operatingsystem ? {
    freebsd => "apache20",
    debian  => "apache2",
    ubuntu  => "apache2",
    default => "httpd",
}

$servicename = $operatingsystem ? {
    debian  => "apache2",
    ubuntu  => "apache2",
    default => "httpd",
}

$servicepattern = $operatingsystem ? {
    debian  => "/usr/sbin/apache2",
    ubuntu  => "/usr/sbin/apache2",
    default => "/usr/sbin/httpd",
}

$username = $operatingsystem ? {
    debian  => "www-data",
    ubuntu  => "www-data",
    default => "apache",
}

$configfile = $operatingsystem ?{
    freebsd => "/usr/local/etc/apache20/httpd.conf",
    ubuntu  => "/etc/apache2/apache2.conf",
    debian  => "/etc/apache2/apache2.conf",
    default => "/etc/httpd/conf/httpd.conf",
}

$configdir = $operatingsystem ?{
    freebsd => "/usr/local/etc/apache20",
    ubuntu  => "/etc/apache2",
    debian  => "/etc/apache2",
    default => "/etc/httpd/conf",
}

$documentroot = $operatingsystem ?{
    debian  => "/var/www",
    ubuntu  => "/var/www",
    suse    => "/srv/www",
    default => "/var/www/html",
}

}
