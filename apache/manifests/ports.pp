# Define: apache::ports
#
# Basic ports.conf management define
#
# Usage:
# With standard template:
# apache::ports    { "8080": }
# apache::ports    { "8080": https => "8443" }
#
define apache::ports ( $https='' ) {

    require apache::params

    # Configure the template
    $ports_http = "$name"
    $ports_https = $https ? {
        ''      => "443",
	default => $https,
    }

    file { "ApachePorts_$name":
        path    => "/etc/apache2/ports.conf",
        mode    => "${apache::params::configfile_mode}",
        owner   => "${apache::params::configfile_owner}",
        group   => "${apache::params::configfile_group}",
        require => Package["apache"],
        ensure  => present,

        content => template("apache/ports.erb"),
    }

}
