define monitor::process (
    $process,
    $argument="",
    $service,
    $pidfile,
    $tool,
    $enable='true'
    ) {

    if ( $debug == "yes" ) or ( $debug == true ) {
        require puppet::params
        require puppet::debug 
    }

    if ($tool =~ /munin/) {
        if ( $debug == "yes" ) or ( $debug == true ) {
            file { "${puppet::params::debugdir}/todo/monitor-process-munin_$name":
                ensure => present,
                content => "Name: $name \nProcess: $process \nService: $service \nPidfile: $pidfile \nTool: $tool \nEnable: $enable\n"
            }
        }
    }

    if ($tool =~ /collectd/) {
        if ( $debug == "yes" ) or ( $debug == true ) {
            file { "${puppet::params::debugdir}/todo/monitor-process-collectd_$name":
                ensure => present,
                content => "Name: $name \nProcess: $process \nService: $service \nPidfile: $pidfile \nTool: $tool \nEnable: $enable\n"
            }
        }
    }

    if ($tool =~ /monit/) {
        monitor::process::monit { "$name":
            pidfile  => $pidfile,
            argument => $argument,
            process  => $process,
            service  => $service,
            enable   => $enable,
        }
    }

    if ($tool =~ /nagios/) {
        monitor::process::nagios { "$name":
            pidfile  => $pidfile,
            argument => $argument,
            process  => $process,
            service  => $service,
            enable   => $enable,
        }
    }

    if ($tool =~ /puppi/) {
        monitor::process::puppi { "$name":
            pidfile  => $pidfile,
            argument => $argument,
            process  => $process,
            service  => $service,
            enable   => $enable,
        }
    }




if ($debug != "false") and ($debug != "no") and ($debug != false) {

    include puppet::params
    file { "puppet_debug_variables_monitor-$name":
        path    => "${puppet::params::debugdir}/variables/monitor-$name",
        mode    => "${puppet::params::configfile_mode}",
        owner   => "${puppet::params::configfile_owner}",
        group   => "${puppet::params::configfile_group}",
        ensure  => present,
        require => File["puppet_debug_variables"],
        content => template("monitor/variables_process.erb"),
    }

} # End if $debug

}

