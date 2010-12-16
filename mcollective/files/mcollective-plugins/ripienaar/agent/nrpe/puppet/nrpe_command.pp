define nrpe_command ($command, $parameters="", $cplugdir="auto", $ensure="present") {

    # find out the default nagios paths for plugis
    $defaultdir = $architecture ? {
        "x86_64" => "/usr/lib64/nagios/plugins",
        default  => "/usr/lib/nagios/plugins" }

    # if we overrode cplugdir then use that, else go with the nagios default
    # for this architecture
    case $cplugdir {
        auto:    { $plugdir = $defaultdir }
        default: { $plugdir = $cplugdir }
    }


    case $ensure {
        "absent":    {
                        file{"/etc/nagios/nrpe.d/${name}.cfg":
                            ensure    => absent
                        }
                    }
        default:    {
                        file {"/etc/nagios/nrpe.d/${name}.cfg": 
                            owner => root,
                            group => root,
                            mode => 644,
                            content => template("nagios/nrpe-config.erb"),
                            require => File["/etc/nagios/nrpe.d"],
                        }            
                    }
    }
}
