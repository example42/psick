define monitor::process (
    $process,
    $service,
    $pidfile,
    $enable
    ) {

if ($enable != "false") and ($enable != "no") and ($enable != false) {

    if $monitor_munin == "yes" {
    }

    if $monitor_monit == "yes" {
        monitor::process::monit { "$name":
            pidfile => "$pidfile",
            process => "$process",
            service => "$service",
        }
    }

    if $monitor_collectd == "yes" {
    }

    if $monitor_nagios == "yes" {
        monitor::process::nagios { "$name":
            process => $process,
        }
    }

} # End if $enable


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

